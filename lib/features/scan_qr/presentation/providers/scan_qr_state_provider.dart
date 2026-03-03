import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQrState {
  final bool isScanning;
  final bool isLoading;
  final String? errorMessage;
  final String? scannedQrCode; // Simple field for storing scanned QR

  const ScanQrState({
    this.isScanning = false,
    this.isLoading = false,
    this.errorMessage,
    this.scannedQrCode,
  });

  ScanQrState copyWith({
    bool? isScanning,
    bool? isLoading,
    String? errorMessage,
    String? scannedQrCode,
  }) {
    return ScanQrState(
      isScanning: isScanning ?? this.isScanning,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      scannedQrCode: scannedQrCode ?? this.scannedQrCode,
    );
  }

  bool get hasError => errorMessage != null;
  bool get isSuccess => scannedQrCode != null && !hasError;
}

class ScanQrNotifier extends Notifier<ScanQrState> {
  @override
  ScanQrState build() {
    return const ScanQrState();
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

  void clear() {
    state = const ScanQrState();
  }
}

final scanQrStateProvider =
    NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
