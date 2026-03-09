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
  
  const CheckInState({
    this.currentStep = CheckInLoadingStep.idle,
    this.errorMessage,
  });

  CheckInState copyWith({CheckInLoadingStep? currentStep, String? errorMessage}) {
    return CheckInState(
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => currentStep != CheckInLoadingStep.idle;
  
  String get loadingMessage {
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
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);