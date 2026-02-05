import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/features/auth/data/dtos/dtos.dart';
import 'package:pos/features/auth/data/models/user_model.dart';
import 'package:pos/features/auth/data/repositories/auth_repository_impl.dart';

abstract class AuthRemoteDataSource {
  // :: Login a user with username and password
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
      // Create login request DTO
      final request = LoginRequest(
        username: username,
        password: password,
      );

      final result = await _apiClient.post(ApiEndpoints.login,
        data: request.toJson(),
      );

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) async {
          // Parse response using DTO
          final authResponse = AuthResponse.fromJson(response);

          // Save tokens to secure storage
          await _secureStorageService.write(
            key: AppConstants.tokenKey,
            value: authResponse.accessToken,
          );

          await _secureStorageService.write(
            key: AppConstants.refreshTokenKey,
            value: authResponse.refreshToken,
          );

          return authResponse.user;
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
