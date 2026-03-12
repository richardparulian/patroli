import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> with WidgetsBindingObserver {
  late MobileScannerController _controller;
  late ProviderSubscription<ScanQrState> _scanQrListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );

    ref.read(scanQrProvider.notifier).setController(_controller);

    // _scanQrListener = ref.listenManual(scanQrProvider, (prev, next) {
    //   if (next.isSuccess && next.entity != null && mounted) { 
    //     final entity = next.entity;

    //     ref.read(scanQrProvider.notifier).clear();

    //     context.pushReplacement(AppConstants.checkInRoute, extra: entity);
    //   } else if (next.errorMessage != null && mounted) {  
    //     ref.read(scanQrProvider.notifier).setProcessing(false);

    //     AppDialog.showError(
    //       context: context,
    //       title: 'Gagal',
    //       message: next.errorMessage ?? 'Terjadi kesalahan saat memindai kode QR',
    //       buttonText: 'Oke',
    //       onButtonPressed: () async {
    //         ref.read(scanQrProvider.notifier).clear();
    //         await _rebuildScanner();
    //       },
    //     );
    //   }
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission(isCheckPermission: true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    _scanQrListener.close();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _checkCameraPermission(isCheckPermission: false);
      });
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

    ref.read(scanQrProvider.notifier).setController(newController);

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
      notifier.setErrorMessage('Kode QR tidak ditemukan pada gambar!');
    }
  }

  Future<void> _onScanned(String qrCode) async {
    final notifier = ref.read(scanQrProvider.notifier);

    await notifier.pauseScanner();

    if (!mounted) return;
    await notifier.scanQr(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading)); 

    ref.listen(scanQrProvider, (prev, next) {
      next.when(
        idle: () => null,
        loading: () {
          _cameraController?.pausePreview();
        },
        success: (val) {
          final entity = val;

          ref.read(scanQrProvider.notifier).clear();

          context.pushReplacement(AppConstants.checkInRoute, extra: entity);
        },
        error: (msg) {
          AppDialog.showError(
            context: context,
            title: 'Gagal',
            message: msg,
            buttonText: 'Oke',
            onButtonPressed: () async {
              ref.read(scanQrProvider.notifier).clear();

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
    final colorScheme = theme.colorScheme;

    final state = ref.watch(scanQrProvider);
    final isError = ref.watch(scanQrProvider.select((s) => s.isError));
    final isLoading = ref.watch(scanQrProvider.select((s) => s.isLoading));
    final isProcessing = ref.watch(scanQrProvider.select((s) => s.isProcessing));

    return AiBarcodeScanner(
      key: ValueKey(_controller),
      controller: _controller,
      galleryButtonType: GalleryButtonType.none,
      appBarBuilder: (context, controller) {
        return _buildAppBar(state.isTorchOn);
      },
      onDetect: (value) {
        if (isLoading || isProcessing) return;

        if (value.barcodes.isNotEmpty) {
          ref.read(scanQrProvider.notifier).setProcessing(true);

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
        animationColor: colorScheme.primary,
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
                  onTap: () => ref.read(scanQrProvider.notifier).toggleTorch(),
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
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(CupertinoIcons.question_circle, color: colorScheme.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kendala Scan Kode QR?',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text('Silakan unggah kode QR dari galeri atau masukan kode cabang pada menu dibawah ini.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                  onPressed: isLoading ? null : null,
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
