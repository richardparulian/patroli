import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/datasources/pre_sign_remote_data_source.dart';
import 'package:pos/features/pre_sign/data/models/pre_sign_model.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignRepositoryImpl implements PreSignRepository {
  final PreSignRemoteDataSource _remoteDataSource;

  PreSignRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<PreSignEntity>>> getPreSigns() async {
    try {
      final models = await _remoteDataSource.fetchPreSigns();
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch pre_signs'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreSignEntity>> getPreSign(int id) async {
    try {
      final model = await _remoteDataSource.fetchPreSign(id);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch pre_sign'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final preSignRepositoryProvider =
    Provider<PreSignRepository>((ref) {
  final remoteDataSource = ref.watch(preSignRemoteDataSourceProvider);
  return PreSignRepositoryImpl(remoteDataSource);
});
