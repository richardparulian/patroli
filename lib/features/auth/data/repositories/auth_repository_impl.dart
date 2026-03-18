import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/storage/local_storage_service.dart';
import 'package:patroli/core/storage/secure_storage_service.dart';
import 'package:patroli/core/storage/storage_keys.dart';
import 'package:patroli/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:patroli/features/auth/data/dtos/request/login_request.dart';
import 'package:patroli/features/auth/data/models/user_model.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';
import 'package:patroli/features/auth/domain/repositories/auth_repository.dart';

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
      await _localStorageService.setObject(StorageKeys.userData, response.toJson());

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
      await _localStorageService.remove(StorageKeys.userData);

      // Remove auth token from secure storage
      await _secureStorageService.delete(key: StorageKeys.token);

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
        key: StorageKeys.token,
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
      final userData = _localStorageService.getObject(StorageKeys.userData);

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
