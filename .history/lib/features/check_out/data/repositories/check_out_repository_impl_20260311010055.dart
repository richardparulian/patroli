import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/check_out/data/datasources/check_out_remote_data_source.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';
import 'package:pos/features/check_out/domain/repositories/check_out_repository.dart'; 

class CheckOutRepositoryImpl implements CheckOutRepository {
  final CheckOutRemoteDataSource _remoteDataSource;

  CheckOutRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CheckOutEntity>> createCheckOut(CheckOutRequest request, int reportId) async {
    try {
      final model = await _remoteDataSource.createCheckOut(request, reportId);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch check out'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final checkOutRepositoryProvider = Provider<CheckOutRepository>((ref) {
  final remoteDataSource = ref.watch(checkOutRemoteDataSourceProvider);
  return CheckOutRepositoryImpl(remoteDataSource);
});
