import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/bottom_sheets/app_bottom_sheet.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_camera_provider.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> with WidgetsBindingObserver {
  late MobileScannerController _controller;
  late ProviderSubscription<ScanQrState> _scanQrListener;
  final TextEditingController _branchCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );

    ref.read(scanCameraProvider.notifier).setController(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission(isCheckPermission: false);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    _scanQrListener.close();
    _branchCodeController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.resumed) {
      // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   await _checkCameraPermission(isCheckPermission: false);
      // });
    }
  }

  Future<void> _checkCameraPermission({required bool isCheckPermission}) async { 
    final hasPermission = await PermissionService.checkAndRequestCameraPermission(
      context: context,
      isCheckPermission: isCheckPermission,
    );

    if (hasPermission) {
      await _controller.start();
    }
  }

  Future<void> _rebuildScanner() async {
    final oldController = _controller;

    final newController = MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );

    setState(() {
      _controller = newController;
    });

    ref.read(scanCameraProvider.notifier).setController(newController);

    await oldController.dispose();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission(isCheckPermission: false);
    });
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;
    if (!mounted) return;

    final result = await _controller.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final barcode = result.barcodes.first;
      final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';

      await _onScanned(qrCode);
    } else {
      final notifier = ref.read(scanQrProvider.notifier);
      notifier.setError(message: 'Kode QR tidak ditemukan pada gambar!');
    }
  }

  Future<void> _onScanned(String qrCode) async {
    final scanQr = ref.read(scanQrProvider.notifier);

    if (!mounted) return;
    await scanQr.runScanQr(qrCode);
  }

  Future<void> _showBranchCodeModal() async {
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading));

    await AppBottomSheet.showWithKeyboard(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBottomSheet.buildHeader(
            context: context,
            title: 'Masukkan Kode Cabang',
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: _branchCodeController,
            label: 'Kode Cabang',
            hint: 'Masukkan kode cabang contoh: KYB001-1',
            keyboardType: TextInputType.text,
            prefixIcon: const Icon(Iconsax.code),
          ),
          const SizedBox(height: 16),
          AppIconButton(
            label: 'Lanjut',
            icon: const Icon(Iconsax.next),
            minimumSize: const Size(double.infinity, 45),
            onPressed: isLoading ? null : () async {
              final branchCode = _branchCodeController.text.trim();

              if (branchCode.isEmpty) return;
              if (!mounted) return;
              
              context.pop();

              await _onScanned(branchCode);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading)); 

    ref.listen(scanQrProvider, (prev, next) {
      next.when(
        idle: () => null,
        loading: () {},
        success: (val) {
          final entity = val;

          ref.read(scanCameraProvider.notifier).pauseScanner();
  
          context.pushReplacement(AppConstants.checkInRoute, extra: entity);
        },
        error: (msg) {
          ref.read(scanCameraProvider.notifier).pauseScanner();
          ref.read(scanCameraProvider.notifier).setProcessing(false);

          if (!mounted) return;
          AppDialog.showError(
            context: context,
            title: 'Gagal',
            message: msg,
            buttonText: 'Oke',
            onButtonPressed: () async {
              // ref.read(scanQrProvider.notifier).clear();
              await _rebuildScanner();
            },
          );
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildScanner(),
          ),
          if (isLoading) ...[
            AppLoading(message: 'Memproses kode QR...'),
          ],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPoweredBy(),
                _buildBottomMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final cameraState = ref.watch(scanCameraProvider);
    final isError = ref.watch(scanQrProvider.select((s) => s.isError));
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading));
    final isProcessing = ref.watch(scanCameraProvider.select((s) => s.isProcessing));

    return AiBarcodeScanner(
      key: ValueKey(_controller),
      controller: _controller,
      galleryButtonType: GalleryButtonType.none,
      appBarBuilder: (context, controller) {
        return _buildAppBar(cameraState.isTorchOn);
      },
      onDetect: (value) {
        if (isLoading || isProcessing) return;

        if (value.barcodes.isNotEmpty) {
          ref.read(scanCameraProvider.notifier).setProcessing(true);

          final barcode = value.barcodes.first;
          final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
          
          _onScanned(qrCode);
        }
      },
      validator: (value) {
        return value.barcodes.isNotEmpty;
      },
      onDispose: () {
        debugPrint('Scanner disposed');
      },
      onDetectError: (Object error, StackTrace stackTrace) {
        // setState(() => _isScannerRunning = false);
        debugPrint('Scanner error: $error');
      },
      overlayConfig: ScannerOverlayConfig(
        curve: Curves.easeInOut,
        borderColor: Colors.transparent,
        animationColor: color.primary,
        scannerBorder: ScannerBorder.none,
        scannerAnimation: isError ? ScannerAnimation.none : ScannerAnimation.fullWidth,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isTorchOn) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade800,
              child: Icon(Iconsax.arrow_left, color: Colors.grey.shade400),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => ref.read(scanCameraProvider.notifier).toggleTorch(),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade800,
                    child: Icon(isTorchOn ? Iconsax.flash_slash : Iconsax.flash_1, color: Colors.grey.shade400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPoweredBy() {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Powered by',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Image.asset('assets/images/logos/pgi-horizontal-white.webp', height: 25, fit: BoxFit.contain),
        ],
      ),
    );
  }

  Widget _buildBottomMenu() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16, 
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAlertCard(
            title: 'Kendala Scan Kode QR?',
            message: 'Silakan unggah kode QR dari galeri atau masukan kode cabang pada menu dibawah ini.', 
            type: AlertType.custom,
            customIcon: CupertinoIcons.question_circle,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppIconButton(
                  onPressed: isLoading ? null : () => _pickImageFromGallery(),
                  icon: const Icon(Iconsax.gallery_add5),
                  label: 'Unggah dari galeri',
                  type: IconButtonType.outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppIconButton(
                  onPressed: isLoading ? null : () => _showBranchCodeModal(),
                  icon: const Icon(Iconsax.keyboard5),
                  label: 'Input kode cabang',
                  type: IconButtonType.outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
