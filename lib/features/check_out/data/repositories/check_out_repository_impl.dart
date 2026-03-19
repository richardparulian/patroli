import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/check_out/data/datasources/check_out_remote_data_source.dart';
import 'package:patroli/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:patroli/features/check_out/domain/entities/check_out_entity.dart';
import 'package:patroli/features/check_out/domain/repositories/check_out_repository.dart';

class CheckOutRepositoryImpl implements CheckOutRepository {
  final CheckOutRemoteDataSource _remoteDataSource;

  CheckOutRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CheckOutEntity>> createCheckOut(
    CheckOutRequest request,
    int reportId,
  ) async {
    try {
      final model = await _remoteDataSource.createCheckOut(request, reportId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
