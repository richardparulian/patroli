import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQrState {
  final bool isTorchOn;
  final bool isLoading;

  const ScanQrState({
    this.isTorchOn = false,
    this.isLoading = false,
  });

  ScanQrState copyWith({bool? isTorchOn, bool? isLoading}) {
      return ScanQrState(
        isTorchOn: isTorchOn ?? this.isTorchOn,
        isLoading: isLoading ?? this.isLoading,
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
