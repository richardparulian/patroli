import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQrState {
  final bool isTorchOn;
  final bool isProcessing;
  final bool isCameraPermissionGranted;

  const ScanQrState({
    this.isTorchOn = false,
    this.isProcessing = false,
    this.isCameraPermissionGranted = false,
  });

  ScanQrState copyWith({bool? isTorchOn, bool? isProcessing,  bool? isCameraPermissionGranted}) {
    return ScanQrState(
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isProcessing: isProcessing ?? this.isProcessing,
      isCameraPermissionGranted: isCameraPermissionGranted ?? this.isCameraPermissionGranted,
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

  void setCameraPermissionGranted(bool isCameraPermissionGranted) {
    state = state.copyWith(isCameraPermissionGranted: isCameraPermissionGranted);
  }
}

final scanCameraProvider = NotifierProvider.autoDispose<ScanCameraNotifier, ScanQrState>(ScanCameraNotifier.new);