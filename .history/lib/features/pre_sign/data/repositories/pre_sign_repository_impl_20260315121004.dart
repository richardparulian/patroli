import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/datasources/pre_sign_remote_data_source.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_update_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pre_sign_repository_impl.g.dart';

class PreSignRepositoryImpl implements PreSignRepository {
  final PreSignRemoteDataSource _remoteDataSource;

  PreSignRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PreSignCreateEntity>> postPreSign(PreSignCreateRequest request) async {
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
  Future<Either<Failure, PreSignUpdateEntity>> putPreSign(String url, XFile image) async {
    try {
      final response = await _remoteDataSource.putPreSign(url, image);

      return Right(response.toEntity());
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

@riverpod
PreSignRepository preSignRepository(Ref ref) {
  final remoteDataSource = ref.watch(preSignRemoteDataSourceProvider);
  return PreSignRepositoryImpl(remoteDataSource);
}
