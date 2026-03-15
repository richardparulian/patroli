import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/core/providers/storage_providers.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/features/auth/data/dtos/dtos.dart';
import 'package:pos/features/auth/data/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

abstract class AuthRemoteDataSource {
  // :: Login a user with username and password
  Future<UserModel> login(LoginRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;

  AuthRemoteDataSourceImpl(
    this._apiClient,
    this._secureStorageService,
  );

  @override
  Future<UserModel> login(LoginRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.login,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) async {
        // Parse response using DTO
        final loginResponse = LoginResponse.fromJson(response);

        // Save tokens to secure storage
        await _secureStorageService.write(
          key: AppConstants.tokenKey,
          value: loginResponse.data.token,
        );

        return loginResponse.data.user;
      },
    );
  }
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return AuthRemoteDataSourceImpl(apiClient, secureStorageService);
}
