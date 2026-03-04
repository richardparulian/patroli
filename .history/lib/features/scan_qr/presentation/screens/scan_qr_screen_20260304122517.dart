import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/services/permission_service.dart';
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
  late bool _isScannerRunning;
  late MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _isScannerRunning = false;
    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );

    // Check camera permission when screen first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCameraPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _isScannerRunning = false;

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

    if (hasPermission && !_isScannerRunning) {
      _isScannerRunning = true;
      _controller.start();
    }
  }

  Future<void> _onScanned(String qrCode) async {
    final scanQrUseCase = ref.read(scanQrUseCaseProvider);
    final isValidQrCode = scanQrUseCase.isValidQrCode(qrCode);

    if (!isValidQrCode) return;

    await _controller.pause();
    
    final controller = ref.read(scanQrProvider.notifier);
    await controller.scanQr(
      request: ScanQrRequest(qrcode: qrCode),
    );
    
    final state = ref.read(scanQrProvider);

    state.when(
      data: (entity) {
        if (mounted) {
          context.pushReplacement(AppConstants.checkInRoute, extra: entity);
        }
      },
      loading: () => null,
      error: (error, _) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: $error')),
          );
          _controller.start();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
  
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AiBarcodeScanner(
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
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade800,
                                child: Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.grey.shade400),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade800,
                                child: Icon(Iconsax.flash_1, color: Colors.grey.shade400),
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
                ref.read(scanQrStateProvider.notifier).setError('Failed to scan QR code');
              },
              overlayConfig: ScannerOverlayConfig(
                curve: Curves.easeInOut,
                borderColor: Colors.transparent,
                animationColor: colorScheme.primary,
                scannerBorder: ScannerBorder.none,
                scannerAnimation: ScannerAnimation.fullWidth,
              ),
              
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, 
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Iconsax.info_circle,
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kendala Scan QR?',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Silakan refresh halaman jika QR Code tidak terbaca',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                          ),
                          child: Text('Unggah dari album'),
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
                          child: Text('Unggah dari album'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
