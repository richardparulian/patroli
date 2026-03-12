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
  final T data;

  const Success(this.data);
}

class Error<T> extends ResultState<T> {
  final String message;

  const Error(this.message);
}

// extension ResultStateX<T> on ResultState<T> {

//   /// shortcut state checking
//   bool get isLoading => this is Loading<T>;
//   bool get isSuccess => this is Success<T>;
//   bool get isError => this is Error<T>;
//   bool get isIdle => this is Idle<T>;

//   /// get data or throw error
//   T get dataOrThrow {
//     if (this is Success<T>) {
//       return (this as Success<T>).data;
//     }

//     if (this is Error<T>) {
//       throw Exception((this as Error<T>).message);
//     }

//     throw Exception('State tidak valid');
//   }

//   /// pattern matching (clean UI handling)
//   R when<R>({required R Function() idle, required R Function() loading, required R Function(T data) success, required R Function(String message) error}) {

//     if (this is Idle<T>) {
//       return idle();
//     }

//     if (this is Loading<T>) {
//       return loading();
//     }

//     if (this is Success<T>) {
//       return success((this as Success<T>).data);
//     }

//     if (this is Error<T>) {
//       return error((this as Error<T>).message);
//     }

//     throw Exception('Unknown state');
//   }
// }