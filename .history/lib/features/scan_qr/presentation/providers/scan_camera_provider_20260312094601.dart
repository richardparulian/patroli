import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';

class ScanQrState {
  final bool isTorchOn;
  final bool isProcessing;

  const ScanQrState({
    this.isTorchOn = false,
    this.isProcessing = false,
  });

  ScanQrState copyWith({
    bool? isTorchOn, 
    bool? isProcessing, 
  }) {
    return ScanQrState(
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ScanCameraNotifier extends Notifier<ScanQrState> {
  MobileScannerController? _controller;
  
  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  void setController(MobileScannerController controller) {
    _controller = controller;
  }

  Future<void> pauseScanner() async {
    await _controller?.pause();
  }

  Future<void> startScanner() async {
    await _controller?.start();
  }

  void setProcessing(bool isProcessing) {
    state = state.copyWith(isProcessing: isProcessing);
  }

  Future<void> toggleTorch() async {
    if (_controller == null) return;

    await _controller?.toggleTorch();
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  Future<void> checkCameraPermission({bool? isCheckPermission}) async { 
    final hasPermission = await PermissionService.checkAndRequestCameraPermission(
      isCheckPermission: isCheckPermission ?? false,
    );

    if (hasPermission) {
      await _controller?.start();
    }
  }

  Future<void> rebuildScanner() async {
    final oldController = _controller;

    final newController = MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );

    _controller = newController;

    ref.read(scanCameraProvider.notifier).setController(newController);

    await oldController?.dispose();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkCameraPermission(isCheckPermission: false);
    });
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final result = await _controller?.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final barcode = result.barcodes.first;
      final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';

      await onScanned(qrCode);
    } else {
      setProcessing(false);
      
      final notifier = ref.read(scanQrProvider.notifier);
      notifier.setError(message: 'Kode QR tidak ditemukan pada gambar!');
    }
  }

  Future<void> onScanned(String qrCode) async {
    final scanQr = ref.read(scanQrProvider.notifier);

    await pauseScanner();

    await scanQr.runScanQr(qrCode);
  }
}

final scanCameraProvider = NotifierProvider<ScanCameraNotifier, ScanQrState>(ScanCameraNotifier.new);