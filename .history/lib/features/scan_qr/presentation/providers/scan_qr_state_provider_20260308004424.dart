import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
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
    if (_controller != null) {
      try {
        _controller!.dispose();
        debugPrint('Disposed old camera controller in notifier');
      } catch (e) {
        debugPrint('Error disposing old controller: $e');
      } finally {
        _controller = null;
      }
    }
    
    _controller = controller;
  }

  void reset() {
    if (_controller != null) {
      try {
        _controller!.dispose();
        debugPrint('Disposed camera controller on reset');
      } catch (e) {
        debugPrint('Error disposing controller on reset: $e');
      } finally {
        _controller = null;
      }
    }
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
