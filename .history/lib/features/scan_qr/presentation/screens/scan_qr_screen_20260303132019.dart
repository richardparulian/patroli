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
    // 1. PAUSE scanner untuk mencegah multiple scan
    await _controller.pause();
    
    // 2. HIT API dengan loading
    final controller = ref.read(scanQrProvider.notifier);
    await controller.scanQr(
      request: ScanQrRequest(qrcode: qrCode),
    );
    
    // 3. HANDLE RESULT
    final state = ref.read(scanQrProvider);
    state.when(
      data: (_) {
        // ✅ SUCCESS: Redirect ke check_in screen
        if (mounted) {
          context.push(AppConstants.checkInRoute);
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
    // final state = ref.watch(scanQrStateProvider);

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

          // // ===== SCAN FRAME =====
          // Center(
          //   child: Container(
          //     width: 260,
          //     height: 260,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(24),
          //       border: Border.all(
          //         width: 3,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

          // ===== TOP BAR =====
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //   onTap: () => context.pop(),
                  //   child: Icon(Iconsax.arrow_left, color: Colors.white),
                  // ),
                  // const Text('Scan QR Code',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // IconButton(
                  //   icon: Icon(
                  //     isFlashOn ? Icons.flash_on : Icons.flash_off,
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () {
                  //     ref.read(flashProvider.notifier).state = !isFlashOn;
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Container(
      //     padding: const EdgeInsets.all(20),
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.vertical(
      //         top: Radius.circular(28),
      //       ),
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Container(
      //           width: 40,
      //           height: 4,
      //           margin: const EdgeInsets.only(bottom: 16),
      //           decoration: BoxDecoration(
      //             color: Colors.grey.shade300,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //         ),
      //         const Text('Arahkan kamera ke QR Code',
      //           style: TextStyle(
      //             fontSize: 16,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         const Text('Pastikan QR berada di dalam kotak untuk memindai secara otomatis.',
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //             fontSize: 14,
      //             color: Colors.grey,
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         SizedBox(
      //           width: double.infinity,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               padding: const EdgeInsets.symmetric(vertical: 14),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //             ),
      //             onPressed: () {
      //               // TODO: Open gallery to scan from image
      //             },
      //             child: const Text('Scan dari Galeri'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
