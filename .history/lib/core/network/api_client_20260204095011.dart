import 'package:fpdart/fpdart.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../core/error/failures.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  // GET request
  Future<Either<Failure, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // POST request
  Future<Either<Failure, dynamic>> post(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // PUT request
  Future<Either<Failure, dynamic>> put(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: options,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // PATCH request
  Future<Either<Failure, dynamic>> patch(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: options,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // DELETE request
  Future<Either<Failure, dynamic>> delete(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        options: options,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // Handle Dio errors
  Failure _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        return _handleErrorResponse(e);
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request cancelled');
      case DioExceptionType.unknown:
        return _handleUnknownError(e);
      default:
        return const ServerFailure(message: 'Unknown error occurred');
    }
  }

  // Handle error responses from server
  Failure _handleErrorResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    // Try to extract message from response data
    String? errorMessage;
    if (responseData is Map<String, dynamic>) {
      errorMessage = responseData['message'] as String? ??
          responseData['error'] as String?;
    }

    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: errorMessage ?? 'Bad Request',
        );
      case 401:
        return UnauthorizedFailure(
          message: errorMessage ?? 'Unauthorized - Please login again',
        );
      case 403:
        return ServerFailure(
          message: errorMessage ?? 'Forbidden - You don\'t have permission',
        );
      case 404:
        return ServerFailure(
          message: errorMessage ?? 'Resource not found',
        );
      case 422:
        return ValidationFailure(
          message: errorMessage ?? 'Validation failed',
        );
      case 429:
        return ServerFailure(
          message: errorMessage ?? 'Too many requests - Please try again later',
        );
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerFailure(
          message: errorMessage ?? 'Server error - Please try again later',
        );
      default:
        return ServerFailure(
          message: errorMessage ?? 'Unknown error occurred',
        );
    }
  }

  // Handle unknown errors (network issues, etc.)
  Failure _handleUnknownError(DioException e) {
    final errorString = e.error.toString();

    if (errorString.contains('SocketException') ||
        errorString.contains('NetworkException') ||
        errorString.contains('Failed host lookup')) {
      return const NetworkFailure(
        message: 'No internet connection',
      );
    }

    if (errorString.contains('FormatException')) {
      return const ServerFailure(
        message: 'Invalid data format',
      );
    }

    return ServerFailure(
      message: errorString.isNotEmpty ? errorString : 'Unknown error occurred',
    );
  }

  // Get Dio instance (for advanced usage)
  Dio get dio => _dio;
}