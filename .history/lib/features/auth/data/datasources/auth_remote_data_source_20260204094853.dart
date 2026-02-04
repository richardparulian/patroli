import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Login a user with email and password
  Future<UserModel> login({required String email, required String password});

  /// Register a new user
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
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
      final result = await _apiClient.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (result.isLeft()) {
        final failure = result.getLeft();
        throw ServerException(message: failure?.message ?? 'Login failed');
      }

      final response = result.getOrElse(() => {});

      // Extract user data from response
      final userData = response['user'];
      final token = response['access_token'];
      final refreshToken = response['refresh_token'];

      // Note: Token and refresh token handling is done in AuthInterceptor
      // and in the repository layer. We just return the user data here.

      return UserModel.fromJson(userData);
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

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiClient.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (result.isLeft()) {
        final failure = result.getLeft();
        throw ServerException(message: failure?.message ?? 'Registration failed');
      }

      final response = result.getOrElse(() => {});

      // Extract user data from response
      final userData = response['user'];
      final token = response['access_token'];
      final refreshToken = response['refresh_token'];

      // Note: Token and refresh token handling is done in AuthInterceptor
      // and in the repository layer. We just return the user data here.

      return UserModel.fromJson(userData);
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on BadRequestException {
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
