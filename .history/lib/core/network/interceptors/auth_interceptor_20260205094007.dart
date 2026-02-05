import 'package:dio/dio.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/core/error/exceptions.dart';

/// Interceptor untuk menangani autentikasi pada API requests
/// Menambahkan token ke headers dan melakukan refresh token jika expired
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final Dio _dio;

  AuthInterceptor({
    required SecureStorageService secureStorageService,
    required Dio dio,
  }) : _secureStorageService = secureStorageService, _dio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Get token from secure storage
      final token = await _secureStorageService.read(key: AppConstants.tokenKey);

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
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      try {
        // Try to refresh token
        final newToken = await _refreshToken();

        if (newToken != null) {
          // Update token in secure storage
          await _secureStorageService.write(
            key: AppConstants.tokenKey,
            value: newToken,
          );

          // Retry the original request with new token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newToken';

          // Create new request
          final response = await _dio.fetch(opts);

          // Return successful response
          handler.resolve(response);
          return;
        }
      } catch (refreshError) {
        // Token refresh failed, logout user
        await _logoutUser();
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: UnauthorizedException(message: 'Session expired'),
            type: DioExceptionType.unknown,
          ),
        );
        return;
      }
    }

    // If not 401 or token refresh failed, continue with error
    handler.next(err);
  }

  /// Refresh access token using refresh token
  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _secureStorageService.read(
        key: AppConstants.refreshTokenKey,
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }

      // Make request to refresh token
      final response = await Dio().post(
        '${_dio.options.baseUrl}${ApiEndpoints.refresh}',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        // Save new tokens
        await _secureStorageService.write(
          key: AppConstants.tokenKey,
          value: newToken,
        );

        if (newRefreshToken != null) {
          await _secureStorageService.write(
            key: AppConstants.refreshTokenKey,
            value: newRefreshToken,
          );
        }

        return newToken;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Logout user - remove all tokens and user data
  Future<void> _logoutUser() async {
    try {
      await _secureStorageService.delete(key: AppConstants.tokenKey);
      await _secureStorageService.delete(key: AppConstants.refreshTokenKey);
    } catch (e) {
      // Ignore errors during logout
    }
  }
}
