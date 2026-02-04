import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/features/auth/data/models/user_model.dart';
import 'package:pos/features/auth/data/repositories/auth_repository_impl.dart';

abstract class AuthRemoteDataSource {
  /// Login a user with email and password
  Future<UserModel> login({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;

  AuthRemoteDataSourceImpl(
    this._apiClient,
    this._secureStorageService,
  );

  @override
  Future<UserModel> login({required String username, required String password}) async {
    try {
      final result = await _apiClient.post('/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) async {
          // Extract user data from response
          final userData = response['user'];
          final token = response['access_token'];
          final refreshToken = response['refresh_token'];

          // Save tokens to secure storage
          if (token != null) {
            await _secureStorageService.write(
              key: AppConstants.tokenKey,
              value: token,
            );
          }

          if (refreshToken != null) {
            await _secureStorageService.write(
              key: AppConstants.refreshTokenKey,
              value: refreshToken,
            );
          }

          return UserModel.fromJson(userData);
        },
      );
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

// Provider - using dioWithAuth to include auth interceptor
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return AuthRemoteDataSourceImpl(apiClient, secureStorageService);
});

// ApiClient provider - now using dioWithAuth for authenticated requests
final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});
