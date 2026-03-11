import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/check_in/data/datasources/check_in_remote_data_source.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/repositories/check_in_repository.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';
import 'package:pos/features/check_out/domain/repositories/check_in_repository.dart';

class CheckOutRepositoryImpl implements CheckOutRepository {
  final CheckInRemoteDataSource _remoteDataSource;

  CheckOutRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CheckOutEntity>> createCheckOut(CheckOutRequest request) async {
    try {
      final model = await _remoteDataSource.createCheckOut(request);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch check_in'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final checkInRepositoryProvider = Provider<CheckInRepository>((ref) {
  final remoteDataSource = ref.watch(checkInRemoteDataSourceProvider);
  return CheckInRepositoryImpl(remoteDataSource);
});
