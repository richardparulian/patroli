import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/datasources/pre_sign_remote_data_source.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_response_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignRepositoryImpl implements PreSignRepository {
  final PreSignRemoteDataSource _remoteDataSource;

  PreSignRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PreSignEntity>> postPreSign(PreSignRequest request) async {
    try {
      final model = await _remoteDataSource.postPreSign(request);

      return Right(model.toEntity());
     } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, PreSignResponseEntity>> putPreSign(String url, XFile image) async {
    try {
      await _remoteDataSource.putPreSign(url, image);

      return Right(null);
     } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
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
