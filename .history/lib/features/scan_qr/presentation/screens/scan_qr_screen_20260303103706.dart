import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  @override
  void initState() {
    super.initState();

    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      ref.read(scanQrStateProvider.notifier).setError('Camera permission is required to scan QR codes');
    }
  }

  // void _onScanned(String code) {
  //   ref.read(scanQrStateProvider.notifier).setSuccess(code);
  //   context.pop(code);
  // }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(scanQrStateProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Scan QR Code'),
      //   centerTitle: false,
      //   backgroundColor: Colors.black,
      //   leading: IconButton(
      //     icon: const Icon(Icons.close, color: Colors.white),
      //     onPressed: () => context.pop(true),
      //   ),
      // ),
      body: Stack(
        children: [
          AiBarcodeScanner(
            onDetect: (val) {
              // _onScanned(val);
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
              borderColor: AppConstants.primaryColor,        
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
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Iconsax.arrow_left, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  const Text('Scan QR Code',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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

          // ===== BOTTOM PANEL =====
          // Align(
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
        ],
      ),
    );
  }
}
