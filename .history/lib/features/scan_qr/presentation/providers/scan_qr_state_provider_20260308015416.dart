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
  MobileScannerController? _cameraController;

  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  void setController(MobileScannerController controller) {
    _cameraController = controller;
  }

  Future<void> toggleTorch() async {
    if (_cameraController == null) return;

    await _cameraController!.toggleTorch();
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  void clear() {
    state = const ScanQrState();
  }
}

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
