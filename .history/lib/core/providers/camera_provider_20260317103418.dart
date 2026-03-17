import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraState {
  final bool isInitializing;

  const CameraState({
    this.isInitializing = false,
  });

  CameraState copyWith({bool? isInitializing}) {
    return CameraState(
      isInitializing: isInitializing ?? this.isInitializing,
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

}

final cameraProvider =NotifierProvider<CameraNotifier, CameraState>(CameraNotifier.new);

export 'package:patroli/app/camera/camera_provider.dart';