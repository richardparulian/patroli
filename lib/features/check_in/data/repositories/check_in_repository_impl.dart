import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/check_in/data/datasources/check_in_remote_data_source.dart';
import 'package:patroli/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/check_in/domain/repositories/check_in_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInRemoteDataSource _remoteDataSource;

  CheckInRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CheckInEntity>> createCheckIn(CheckInRequest request) async {
    try {
      final model = await _remoteDataSource.createCheckIn(request);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
