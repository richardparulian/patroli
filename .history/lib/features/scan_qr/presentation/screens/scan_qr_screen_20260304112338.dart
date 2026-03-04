import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
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

  bool _isValidQrCode(String qrCode) {
    if (qrCode.isEmpty || qrCode.length < 3) return false;
    
    final validPattern = RegExp(r'^[A-Z]{3}\d{3}-\d+$');
    return validPattern.hasMatch(qrCode);
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
      body: AiBarcodeScanner(
        appBarBuilder: (context, controller) {
          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: colorScheme.onSurface,
                  child: Icon(Iconsax.arrow_left, color: colorScheme.onSurface),
                ),
              ],
            ),
          );
        },
        controller: _controller,
        onDetect: (val) {
          if (val.barcodes.isNotEmpty) {
            final barcode = val.barcodes.first;
            final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
            
            if (_isValidQrCode(qrCode)) _onScanned(qrCode);
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
        overlayConfig: const ScannerOverlayConfig(
          curve: Curves.easeInOut,
          animationColor: Colors.white,
          borderColor: Colors.white,        
        ),
        
      ),
    );
  }
}
