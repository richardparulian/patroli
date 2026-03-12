import 'package:pos/core/extensions/result_state_extension.dart';

extension ResultStateX<T> on ResultState<T> {

  bool get isLoading => this is Loading<T>;

  bool get isSuccess =>
      this is Success<T> && !(this as Success<T>).consumed;

  bool get isError =>
      this is Error<T> && !(this as Error<T>).consumed;

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
}