import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQrState {
  final bool isTorchOn;

  const ScanQrState({
    this.isTorchOn = false,
  });

  ScanQrState copyWith({
    bool? isTorchOn,
  }) {
    return ScanQrState(
      isTorchOn: isTorchOn ?? this.isTorchOn,
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
    _controller = null;
    state = const ScanQrState();
  }
}

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
