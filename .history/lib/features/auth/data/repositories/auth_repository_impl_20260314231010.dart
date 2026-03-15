import 'package:fpdart/fpdart.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/providers/storage_providers.dart';
import 'package:pos/core/storage/local_storage_service.dart';
import 'package:pos/core/storage/secure_storage_service.dart';
import 'package:pos/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pos/features/auth/data/dtos/request/login_request.dart';
import 'package:pos/features/auth/data/models/user_model.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final LocalStorageService _localStorageService;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl(this._remoteDataSource, this._localStorageService, this._secureStorageService);

  @override
  Future<Either<Failure, UserEntity>> login(LoginRequest request) async {
    try {
      final response = await _remoteDataSource.login(request);

      // :: Save user data locally
      await _localStorageService.setObject(AppConstants.userDataKey, response.toJson());

      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Remove user data from local storage
      await _localStorageService.remove(AppConstants.userDataKey);

      // Remove auth token from secure storage
      await _secureStorageService.delete(key: AppConstants.tokenKey);

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await _secureStorageService.read(
        key: AppConstants.tokenKey,
      );
      return Right(token != null && token.isNotEmpty);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userData = _localStorageService.getObject(AppConstants.userDataKey);

      if (userData == null) {
        return const Left(AuthFailure(message: 'User not found'));
      }

      final user = UserModel.fromJson(userData as Map<String, dynamic>);
      
      return Right(user.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localStorageService = ref.watch(localStorageServiceProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);

  return AuthRepositoryImpl(remoteDataSource, localStorageService, secureStorageService);
}
