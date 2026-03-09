import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

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

    // _isScannerRunning = false;

    _controller = MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );

    ref.read(scanQrStateProvider.notifier).setController(_controller);

    _scanQrListener = ref.listenManual(scanQrStateProvider, (prev, next) {
      if (next.isSuccess && next.entity != null && mounted) { 
        final notifier = ref.read(scanQrStateProvider.notifier);

        notifier.pauseScanner();

        final entity = next.entity;

        ref.read(scanQrStateProvider.notifier).clear();

        context.pushReplacement(AppConstants.checkInRoute, extra: entity);
      } 
      
      if (next.errorMessage != null && mounted) {  
        final notifier = ref.read(scanQrStateProvider.notifier);

        notifier.pauseScanner();

        AppDialog.showError(
          context: context,
          title: 'Gagal',
          message: next.errorMessage ?? 'Terjadi kesalahan saat memindai kode QR',
          buttonText: 'Oke',
          onButtonPressed: () async {
            ref.read(scanQrStateProvider.notifier).clear();
            await _rebuildScanner();
          },
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission();
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
    if (state == AppLifecycleState.resumed) {
      _checkCameraPermission();
    }
  }

  Future<void> _rebuildScanner() async {
    final stateNotifier = ref.read(scanQrStateProvider.notifier);

    await _controller.dispose();
    
    setState(() {
      _controller = MobileScannerController(
        autoStart: false,
        formats: [BarcodeFormat.qrCode],
      );
    });

    stateNotifier.setController(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission();
    });
  }

  Future<void> _checkCameraPermission() async { 
    final hasPermission = await PermissionService.checkAndRequestCameraPermission(
      context: context,
    );

    if (hasPermission) {
      final notifier = ref.read(scanQrStateProvider.notifier);

      notifier.startScanner();
    }
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
      final notifier = ref.read(scanQrStateProvider.notifier);
      notifier.setError('Kode QR tidak ditemukan pada gambar!');
    }
  }

  Future<void> _onScanned(String qrCode) async {
    // final scanQrUseCase = ref.read(scanQrUseCaseProvider);
    // final isValidQrCode = scanQrUseCase.isValidQrCode(qrCode);

    // if (!isValidQrCode) {
    //   setState(() => _isScannerRunning = false);
    //   await _controller.pause();
      
    //   if (!mounted) return;
    //   AppDialog.showError(
    //     context: context,
    //     title: 'Gagal memindai kode QR',
    //     message: 'Kode QR tidak valid!',
    //     buttonText: 'Coba lagi',
    //     onButtonPressed: () async => await _rebuildScanner(),
    //   );

    //   return;
    // }

    // final controller = ref.read(scanQrProvider.notifier);
    // await controller.scanQr(
    //   request: ScanQrRequest(qrcode: qrCode),
    // );

    if (!mounted) return;
    await ref.read(scanQrStateProvider.notifier).scanQr(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // final scanQrAsync = ref.watch(scanQrProvider);
    // final scanQrState = ref.watch(scanQrStateProvider);
    final isLoading = ref.watch(scanQrStateProvider.select((s) => s.isLoading)); 

    // ref.listen<AsyncValue>(scanQrProvider, (previous, next) {
    //   next.when(
    //     data: (entity) async {
    //       setState(() {
    //         _isScannerRunning = false;
    //       });
          
    //       if (!mounted || !context.mounted) return;
    //       if (entity == null) return;

    //       context.pushReplacement(AppConstants.checkInRoute, extra: entity);
    //     },
    //     loading: () async {
    //       debugPrint('Scanner loading');
    //       await _controller.pause();
    //     },
    //     error: (error, _) async {
    //       setState(() => _isScannerRunning = false);
          
    //       if (!mounted || !context.mounted) return;
    //       AppDialog.showError(
    //         context: context,
    //         title: 'Gagal memindai kode QR',
    //         message: error.toString(),
    //         buttonText: 'Coba lagi',
    //         onButtonPressed: () async => await _rebuildScanner(),
    //       );
    //     },
    //   );
    // });
  
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
                _buildBottomMenu(theme, colorScheme, isLoading),
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

    final state = ref.watch(scanQrStateProvider);
    final isLoading = ref.watch(scanQrStateProvider.select((s) => s.isLoading));
    final hasError = ref.watch(scanQrStateProvider.select((s) => s.errorMessage != null));

    debugPrint('hasError: $hasError');

    return AiBarcodeScanner(
      key: ValueKey(_controller),
      controller: _controller,
      galleryButtonType: GalleryButtonType.none,
      appBarBuilder: (context, controller) {
        return _buildAppBar(state.isTorchOn);
      },
      onDetect: (value) {
        if (isLoading) return;

        if (value.barcodes.isNotEmpty) {
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
        scannerAnimation: hasError ? ScannerAnimation.none : ScannerAnimation.fullWidth,
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
                  onTap: () => ref.read(scanQrStateProvider.notifier).toggleTorch(),
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

  Widget _buildBottomMenu(ThemeData theme, ColorScheme colorScheme, bool isLoading) {
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
