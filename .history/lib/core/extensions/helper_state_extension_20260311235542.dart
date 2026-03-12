import 'package:pos/core/extensions/result_state_extension.dart';

extension ResultStateX<T> on ResultState<T> {

  bool get isLoading => this is Loading<T>;

  bool get isSuccess =>
      this is Success<T> && !(this as Success<T>).isError;

  bool get isError =>
      this is Error<T> && !(this as Error<T>).isError;

  T? get dataOrNull {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    return null;
  }

  String? get errorMessage {
    if (this is Error<T>) {
      return (this as Error<T>).message;
    }
    return null;
  }

  //   /// get data or throw error
  T get dataOrThrow {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }

    if (this is Error<T>) {
      throw Exception((this as Error<T>).message);
    }

    throw Exception('State tidak valid');
  }

  //   /// pattern matching (clean UI handling)
  R when<R>({required R Function() idle, required R Function() loading, required R Function(T data) success, required R Function(String message) error}) {

    if (this is Idle<T>) {
      return idle();
    }

    if (this is Loading<T>) {
      return loading();
    }

    if (this is Success<T>) {
      return success((this as Success<T>).data);
    }

    if (this is Error<T>) {
      return error((this as Error<T>).message);
    }

    throw Exception('Unknown state');
  }
}