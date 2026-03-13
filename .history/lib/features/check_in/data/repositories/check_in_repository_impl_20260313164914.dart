import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/check_in/data/datasources/check_in_remote_data_source.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/repositories/check_in_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInRemoteDataSource _remoteDataSource;

  CheckInRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CheckInEntity>> createCheckIn(CheckInRequest request) async {
    // try {
      
    // } on ServerException {
    //   return Left(ServerFailure(message: 'Failed to fetch check in'));
    // } on NetworkException {
    //   return Left(NetworkFailure(message: 'No internet connection'));
    // } on Exception catch (e) {
    //   return Left(ServerFailure(message: e.toString()));
    // }
    final model = await _remoteDataSource.createCheckIn(request);
    return Right(model.toEntity());
  }
}

// Provider
final checkInRepositoryProvider = Provider<CheckInRepository>((ref) {
  final remoteDataSource = ref.watch(checkInRemoteDataSourceProvider);
  return CheckInRepositoryImpl(remoteDataSource);
});
