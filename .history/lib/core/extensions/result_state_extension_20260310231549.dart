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


extension ResultStateX<T> on ResultState<T> {

  bool get isSuccess => this is Success<T>;

  bool get isError => this is Error<T>;

  T get dataOrThrow {

    if (this is Success<T>) {
      return (this as Success<T>).data;
    }

    if (this is Error<T>) {
      throw Exception((this as Error<T>).message);
    }

    throw Exception('State tidak valid');

  }

}