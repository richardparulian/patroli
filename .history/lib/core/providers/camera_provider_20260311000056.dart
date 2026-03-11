import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraState {
  final bool isInitializing;
  final bool isReady;

  const CameraState({
    this.isInitializing = false,
    this.isReady = false,
  });

  CameraState copyWith({
    bool? isInitializing,
    bool? isReady,
  }) {
    return CameraState(
      isInitializing: isInitializing ?? this.isInitializing,
      isReady: isReady ?? this.isReady,
    );
  }
}

class CameraNotifier extends Notifier<CameraState> {

  @override
  CameraState build() {
    return const CameraState();
  }

  void setInitializing(bool value) {
    state = state.copyWith(isInitializing: value);
  }

  void setReady(bool value) {
    state = state.copyWith(isReady: value);
  }

}

final cameraProvider =NotifierProvider<CameraNotifier, CameraState>(CameraNotifier.new);