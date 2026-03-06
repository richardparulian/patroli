import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/datasources/pre_sign_remote_data_source.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignRepositoryImpl implements PreSignRepository {
  final PreSignRemoteDataSource _remoteDataSource;

  PreSignRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PreSignEntity>> postPreSign(PreSignRequest request) async {
    try {
      final model = await _remoteDataSource.postPreSign(request);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to post pre_sign'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, PreSignEntity>> putPreSign(String url) async {
    try {
      final model = await _remoteDataSource.putPreSign(url);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to put pre_sign'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final preSignRepositoryProvider = Provider<PreSignRepository>((ref) {
  final remoteDataSource = ref.watch(preSignRemoteDataSourceProvider);
  return PreSignRepositoryImpl(remoteDataSource);
});
