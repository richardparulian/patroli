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
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> with WidgetsBindingObserver {
  // late bool _isScannerRunning;
  late MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // _isScannerRunning = false;
    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.normal,
    );

    ref.read(scanQrStateProvider.notifier).setController(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCameraPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    // _isScannerRunning = false;

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkCameraPermission();
    }
  }

  Future<void> _checkCameraPermission() async {
    final hasPermission = await PermissionService.checkAndRequestCameraPermission(
      context: context,
    );

    final state = ref.read(scanQrStateProvider);

    if (hasPermission && !state.isScanning) {
      ref.read(scanQrStateProvider.notifier).startScanning();
      _controller.start();
    }
  }

  Future<void> _onScanned(String qrCode) async {
    final state = ref.read(scanQrStateProvider);
    final scanQrUseCase = ref.read(scanQrUseCaseProvider);
    final isValidQrCode = scanQrUseCase.isValidQrCode(qrCode);

    if (!isValidQrCode) {
      state.copyWith(isScanning: false);
      await _controller.stop();

      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: 'Gagal memindai kode QR',
        message: 'Kode QR tidak valid!',
        buttonText: 'Coba lagi',
        onButtonPressed: () async => await _checkCameraPermission(),
      );

      return;
    }

    await _controller.pause();
    
    final scanQrController = ref.read(scanQrProvider.notifier);
    await scanQrController.scanQr(
      request: ScanQrRequest(qrcode: qrCode),
    );
    
    final controller = ref.read(scanQrProvider);

    controller.when(
      data: (entity) {
        context.pushReplacement(AppConstants.checkInRoute, extra: entity);
      },
      loading: () => null,
      error: (error, _) async {
        state.copyWith(isScanning: false);
        await _controller.stop();

        if (!mounted) return;
        AppDialog.showError(
          context: context,
          title: 'Gagal memindai kode QR',
          message: error.toString(),
          buttonText: 'Coba lagi',
          onButtonPressed: () async => await _checkCameraPermission(),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;
    if (!mounted) return;

    final state = ref.read(scanQrStateProvider);
    final result = await _controller.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final barcode = result.barcodes.first;
      final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';

      await _onScanned(qrCode);
    } else {
      state.copyWith(isScanning: false);
      await _controller.stop();

      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: 'Gagal memindai kode QR',
        message: 'Kode QR tidak ditemukan pada gambar!',
        buttonText: 'Coba lagi',
        onButtonPressed: () async => await _checkCameraPermission(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final state = ref.watch(scanQrStateProvider);
    final isTorchOn = state.isTorchOn;
  
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildScanner(theme, colorScheme, isTorchOn),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPoweredBy(),
                _buildBottomMenu(theme, colorScheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanner(ThemeData theme, ColorScheme colorScheme, bool isTorchOn) {
    return AiBarcodeScanner(
      galleryButtonType: GalleryButtonType.none,
      appBarBuilder: (context, controller) {
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
                    // GestureDetector(
                    //   onTap: () => _controller.switchCamera(),
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     backgroundColor: Colors.grey.shade800,
                    //     child: Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.grey.shade400),
                    //   ),
                    // ),
                    // const SizedBox(width: 12),
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
      },
      controller: _controller,
      onDetect: (val) {
        if (val.barcodes.isNotEmpty) {
          final barcode = val.barcodes.first;
          final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
          
          _onScanned(qrCode);
        }
      },
      validator: (value) {
        return value.barcodes.isNotEmpty;
      },
      onDispose: () {
        debugPrint('Scanner disposed');
        _controller.stop();
      },
      onDetectError: (Object error, StackTrace stackTrace) {
        // ref.read(scanQrStateProvider.notifier).setError('Failed to scan QR code');
      },
      overlayConfig: ScannerOverlayConfig(
        curve: Curves.easeInOut,
        borderColor: Colors.transparent,
        animationColor: colorScheme.primary,
        scannerBorder: ScannerBorder.none,
        scannerAnimation: ScannerAnimation.fullWidth,
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

  Widget _buildBottomMenu(ThemeData theme, ColorScheme colorScheme) {
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
                child: FilledButton(
                  onPressed: () => _pickImageFromGallery(),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: Text('Unggah dari galeri'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: Text('Input kode cabang'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
