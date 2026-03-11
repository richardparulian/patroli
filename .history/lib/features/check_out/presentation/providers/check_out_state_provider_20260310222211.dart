enum CheckOutLoadingStep {
  processing,
}

class CheckOutState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool isInitialized;
  final String? errorMessage;
  
  const CheckOutState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.isInitialized = false,
    this.errorMessage,
  });

  CheckOutState copyWith({bool? isLoading, bool? isSuccess, bool? isError, bool? isInitialized, String? errorMessage}) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage,
    );
  }
}