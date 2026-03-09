import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CheckInLoadingStep {
  idle,
  takingPhoto,
  creatingPresignedUrl,
  uploadingImage,
  checkingIn,
}

class CheckInState {
  final CheckInLoadingStep currentStep;
  final String? errorMessage;
  final bool isInitializingCamera;
  final String? cameraInitError;

  const CheckInState({
    this.currentStep = CheckInLoadingStep.idle,
    this.errorMessage,
    this.isInitializingCamera = false,
    this.cameraInitError,
  });

  CheckInState copyWith({
    CheckInLoadingStep? currentStep,
    String? errorMessage,
    bool? isInitializingCamera,
    String? cameraInitError,
  }) {
    return CheckInState(
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
      isInitializingCamera: isInitializingCamera ?? this.isInitializingCamera,
      cameraInitError: cameraInitError ?? this.cameraInitError,
    );
  }

  bool get isLoading => currentStep != CheckInLoadingStep.idle || isInitializingCamera;

  String get loadingMessage {
    if (isInitializingCamera) {
      return 'Menginisialisasi kamera...';
    }

    switch (currentStep) {
      case CheckInLoadingStep.takingPhoto:
        return 'Mengambil foto...';
      case CheckInLoadingStep.creatingPresignedUrl:
        return 'Mempersiapkan upload...';
      case CheckInLoadingStep.uploadingImage:
        return 'Mengupload foto selfie...';
      case CheckInLoadingStep.checkingIn:
        return 'Melakukan check-in...';
      case CheckInLoadingStep.idle:
        return '';
    }
  }
}

class CheckInNotifier extends Notifier<CheckInState> {
  @override
  CheckInState build() {
    return const CheckInState();
  }

  void setStep(CheckInLoadingStep step) {
    state = state.copyWith(currentStep: step);
  }

  void setError(String errorMessage) {
    state = state.copyWith(
      currentStep: CheckInLoadingStep.idle,
      errorMessage: errorMessage,
    );
  }

  void clear() {
    state = const CheckInState();
  }

  void setCameraInitializing(bool isInitializing) {
    state = state.copyWith(isInitializingCamera: isInitializing);
    debugPrint('setCameraInitializing: $isInitializing, isLoading: ${state.isLoading}');
  }

  void setCameraInitError(String? error) {
    state = state.copyWith(
      cameraInitError: error,
      isInitializingCamera: false,
    );
    debugPrint('setCameraInitError: $error, isLoading: ${state.isLoading}');
  }
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);