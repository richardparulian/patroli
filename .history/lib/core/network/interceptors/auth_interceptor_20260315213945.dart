import 'package:dio/dio.dart';
import 'package:patroli/core/storage/secure_storage_service.dart';
import 'package:patroli/core/storage/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final Future<void> Function()? _onUnauthorized;

  AuthInterceptor({
    required SecureStorageService secureStorageService,
    Future<void> Function()? onUnauthorized,
  }) : _secureStorageService = secureStorageService,
       _onUnauthorized = onUnauthorized;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (options.extra['skip_auth'] == true) {
        handler.next(options);
        return;
      }

      // Get token from secure storage
      final token = await _secureStorageService.read(
        key: StorageKeys.token,
      );

      // If token exists, add to headers
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      // Continue with request
      handler.next(options);
    } catch (e) {
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _onUnauthorized?.call();
      } catch (_) {}
    }

    handler.next(err);
  }
}
