import 'package:dio/dio.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/storage/secure_storage_service.dart';

/// Interceptor untuk menangani autentikasi pada API requests
/// Menambahkan token ke headers dan melakukan refresh token jika expired
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  // final Dio _dio;

  AuthInterceptor({required SecureStorageService secureStorageService}) : _secureStorageService = secureStorageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Get token from secure storage
      final token = await _secureStorageService.read(
        key: AppConstants.tokenKey,
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
    // Check if error is 401 Unauthorized
    // if (err.response?.statusCode == 401) {
    //   try {
    //     // Try to refresh token
    //     final newToken = await _refreshToken();

    //     if (newToken != null) {
    //       // Update token in secure storage
    //       await _secureStorageService.write(
    //         key: AppConstants.tokenKey,
    //         value: newToken,
    //       );

    //       // Retry original request with new token
    //       final opts = err.requestOptions;
    //       opts.headers['Authorization'] = 'Bearer $newToken';

    //       // Create new request
    //       final response = await _dio.fetch(opts);

    //       // Return successful response
    //       handler.resolve(response);

    //       return;
    //     }
    //   } catch (refreshError) {
    //     // Token refresh failed, logout user
    //     await _logoutUser();
    //     handler.next(
    //       DioException(
    //         requestOptions: err.requestOptions,
    //         error: UnauthorizedException(message: 'Session expired'),
    //         type: DioExceptionType.unknown,
    //       ),
    //     );
    //     return;
    //   }
    // }

    // If not 401 or token refresh failed, continue with error
    handler.next(err);
  }

  /// Refresh access token using refresh token
  // Future<String?> _refreshToken() async {
  //   try {
  //     final refreshToken = await _secureStorageService.read(
  //       key: AppConstants.refreshTokenKey,
  //     );

  //     if (refreshToken == null || refreshToken.isEmpty) {
  //       return null;
  //     }

  //     // Create refresh token request DTO
  //     final request = RefreshTokenRequest.fromToken(refreshToken);

  //     // Make request to refresh token
  //     final response = await Dio().post(
  //       '${_dio.options.baseUrl}${ApiEndpoints.refresh}',
  //       data: request.toJson(),
  //     );

  //     if (response.statusCode == 200 && response.data != null) {
  //       // Parse response using DTO
  //       final refreshResponse = RefreshTokenResponse.fromJson(response.data);

  //       // Save new access token
  //       await _secureStorageService.write(
  //         key: AppConstants.tokenKey,
  //         value: refreshResponse.accessToken,
  //       );

  //       // Save new refresh token if provided
  //       if (refreshResponse.refreshToken != null) {
  //         await _secureStorageService.write(
  //           key: AppConstants.refreshTokenKey,
  //           value: refreshResponse.refreshToken!,
  //         );
  //       }

  //       return refreshResponse.accessToken;
  //     }

  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  /// Logout user - remove all tokens and user data
  // Future<void> _logoutUser() async {
  //   try {
  //     await _secureStorageService.delete(key: AppConstants.tokenKey);
  //     await _secureStorageService.delete(key: AppConstants.refreshTokenKey);
  //   } catch (e) {
  //     // Ignore errors during logout
  //   }
  // }
}
