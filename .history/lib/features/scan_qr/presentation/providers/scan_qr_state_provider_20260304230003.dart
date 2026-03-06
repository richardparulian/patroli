import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQrState {
  final bool isScanning;
  final bool isLoading;
  final String? errorMessage;
  final String? scannedQrCode;
  final bool isTorchOn;

  const ScanQrState({
    this.isScanning = false,
    this.isLoading = false,
    this.errorMessage,
    this.scannedQrCode,
    this.isTorchOn = false,
  });

  ScanQrState copyWith({
    bool? isScanning,
    bool? isLoading,
    String? errorMessage,
    String? scannedQrCode,
    bool? isTorchOn,
  }) {
    return ScanQrState(
      isScanning: isScanning ?? this.isScanning,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      scannedQrCode: scannedQrCode ?? this.scannedQrCode,
      isTorchOn: isTorchOn ?? this.isTorchOn,
    );
  }

  bool get hasError => errorMessage != null;
  bool get isSuccess => scannedQrCode != null && !hasError;
}

class ScanQrNotifier extends Notifier<ScanQrState> {
  MobileScannerController? _controller; 
  
  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  void setController(MobileScannerController controller) {
    _controller = controller;
  }

  void startScanning() {
    state = state.copyWith(isScanning: true, errorMessage: null);
  }

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  void setSuccess(String qrCode) {
    state = state.copyWith(
      scannedQrCode: qrCode,
      isScanning: false,
      isLoading: false,
      errorMessage: null,
    );
  }

  void setError(String message) {
    state = state.copyWith(
      errorMessage: message,
      isScanning: false,
      isLoading: false,
      scannedQrCode: null,
    );
  }

  Future<void> toggleTorch() async {
    if (_controller == null) return;
    
    await _controller!.toggleTorch();
      
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  void clear() {
    state = const ScanQrState();
  }
}

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
