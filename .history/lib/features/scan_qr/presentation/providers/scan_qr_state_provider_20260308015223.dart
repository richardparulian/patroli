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
  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  Future<void> toggleTorch() async {
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  void clear() {
    state = const ScanQrState();
  }
}

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
