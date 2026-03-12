import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrState {
  final bool isError;
  final bool isTorchOn;
  final bool isLoading;
  final bool isSuccess;
  final bool isProcessing;
  final String? errorMessage;
  final ScanQrEntity? entity;

  const ScanQrState({
    this.isError = false,
    this.isTorchOn = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.isProcessing = false,
    this.errorMessage,
    this.entity,
  });

  ScanQrState copyWith({
    bool? isError,
    bool? isTorchOn, 
    bool? isLoading, 
    bool? isSuccess, 
    bool? isProcessing, 
    String? errorMessage, 
    ScanQrEntity? entity,
  }) {
    return ScanQrState(
      isError: isError ?? this.isError,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: errorMessage,
      entity: entity ?? this.entity,
    );
  }
}

class ScanQrNotifier extends Notifier<ResultState<void>> {
  MobileScannerController? _controller;

  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setController(MobileScannerController controller) {
    _controller = controller;
  }

  void setLoading() {
    state = const Loading();
  }

  void setProcessing(bool isProcessing) {
    state = state.copyWith(isProcessing: isProcessing);
  }

  void setErrorMessage(String message) {
    state = state.copyWith(
      isError: true,
      isLoading: false,
      errorMessage: message,
    );
  }

  void onScanQrSuccess(ScanQrEntity entity) {  
    state = state.copyWith(
      isLoading: false,
      isError: false,
      isSuccess: true,
      entity: entity,
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

  Future<void> scanQr(String qrCode) async {
    state = state.copyWith(isLoading: true);

    try {
      final useCase = ref.read(scanQrUseCaseProvider);

      final isValid = useCase.isValidQrCode(qrCode);

      if (!isValid) {
        setErrorMessage('Kode QR tidak valid');
        return;
      }

      await ref.read(scanQrProvider.notifier).scanQr(
        request: ScanQrRequest(qrcode: qrCode),
      );

      final scanQrState = ref.read(scanQrProvider);

      if (scanQrState.hasError) {
        setErrorMessage(scanQrState.error?.toString() ?? 'Terjadi kesalahan saat memindai kode QR');
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));

      debugPrint('scanQrState.value asd: ${scanQrState.value}');

      onScanQrSuccess(scanQrState.value ?? ScanQrEntity());
    } catch (e) {
      setErrorMessage(e.toString());

      return;
    } 
  }

  Future<void> pauseScanner() async {
    await _controller?.pause();
  }

  Future<void> startScanner() async {
    await _controller?.start();
  }
}

final scanQrProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
