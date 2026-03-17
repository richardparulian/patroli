import 'package:dio/dio.dart';
import 'package:patroli/config/app_config.dart';
import 'package:patroli/core/network/interceptors/retry_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  return dio;
}
