import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  late MobileScannerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );

    _requestCameraPermission();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      ref.read(scanQrStateProvider.notifier).setError('Camera permission is required to scan QR codes');
    }
  }

  Future<void> _onScanned(String qrCode) async {
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
      loading: () {
        // ⏳ LOADING: Tampilkan overlay atau widget loading
        // Bisa gunakan overlay di atas scanner
      },
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
    return Scaffold(
      body: Stack(
        children: [
          AiBarcodeScanner(
            appBarBuilder: (context, controller) {
              return AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Iconsax.arrow_left, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
              );
            },
            controller: _controller,
            onDetect: (val) {
              if (val.barcodes.isNotEmpty) {
                final barcode = val.barcodes.first;
                final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
                
                if (qrCode.isNotEmpty) {
                  _onScanned(qrCode);
                }
              }
            },
            onDispose: () {
              debugPrint('Scanner disposed');
            },
            onDetectError: (Object error, StackTrace stackTrace) {
              debugPrint('Error during scan: $error');
              ref.read(scanQrStateProvider.notifier).setError('Failed to scan QR code');
            },
            overlayConfig: const ScannerOverlayConfig(
              curve: Curves.easeInOut,
              animationColor: Colors.white,
              borderColor: Colors.white,        
            ),
            // onDetectPermissionError: (Object error, StackTrace stackTrace) {
            //   debugPrint('Permission error: $error');
            //   ref.read(scanQrStateProvider.notifier).setError(
            //         'Camera permission denied',
            //       );
            // },
            // canPop: false,
            // showOverlay: false,
            // showSuccessIcon: false,
          ),
        ],
      ),
    );
  }
}
