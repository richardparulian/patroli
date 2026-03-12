import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}