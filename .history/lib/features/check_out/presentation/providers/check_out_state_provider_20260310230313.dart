// class CheckOutState {
//   final bool isLoading;
//   final bool isSuccess;
//   final bool isError;
//   final bool isInitialized;
//   final String? errorMessage;
  
//   const CheckOutState({
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.isError = false,
//     this.isInitialized = false,
//     this.errorMessage,
//   });

//   CheckOutState copyWith({bool? isLoading, bool? isSuccess, bool? isError, bool? isInitialized, String? errorMessage}) {
//     return CheckOutState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       isError: isError ?? this.isError,
//       isInitialized: isInitialized ?? this.isInitialized,
//       errorMessage: errorMessage,
//     );
//   }
// }

sealed class ResultState<T> {
  const ResultState();
}

class Idle<T> extends ResultState<T> {
  const Idle();
}

class Loading<T> extends ResultState<T> {
  const Loading();
}

class Success<T> extends ResultState<T> {
  final T? data;

  const Success([this.data]);
}

class Error<T> extends ResultState<T> {
  final String message;

  const Error(this.message);
}