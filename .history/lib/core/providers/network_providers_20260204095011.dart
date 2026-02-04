import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../network/interceptors/retry_interceptor.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage_service.dart';
import '../../config/app_config.dart';
import '../../config/env.dart';

part 'network_providers.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();

  // Use environment-based configuration
  dio.options.baseUrl = AppConfig.apiBaseUrl;
  dio.options.connectTimeout = Duration(milliseconds: AppConfig.apiTimeout);
  dio.options.receiveTimeout = Duration(milliseconds: AppConfig.apiTimeout);
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Add logging interceptor based on environment
  if (AppConfig.isLoggingEnabled) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // Add retry interceptor
  dio.interceptors.add(RetryInterceptor(dio: dio));

  // Add auth interceptor for token management
  // Note: This needs to be added later after secureStorageService is available
  // We'll add it in the dioWithAuth provider

  return dio;
}

@riverpod
Dio dioWithAuth(Ref ref) {
  final dio = ref.watch(dioProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);

  // Add auth interceptor
  dio.interceptors.add(
    AuthInterceptor(
      secureStorageService: secureStorageService,
      dio: dio,
    ),
  );

  return dio;
}
