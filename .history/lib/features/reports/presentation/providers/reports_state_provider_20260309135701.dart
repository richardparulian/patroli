import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const ScanQrState({
    this.isError = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ScanQrState copyWith({
    bool? isError,
    bool? isLoading, 
    bool? isSuccess, 
    String? errorMessage, 
  }) {
    return ScanQrState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
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

  void setError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
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

  void onCheckInSuccess(ScanQrEntity entity) {  
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

      onCheckInSuccess(scanQrState.value ?? ScanQrEntity());
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

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
