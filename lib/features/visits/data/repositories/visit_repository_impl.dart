import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/visits/data/datasources/visit_remote_data_source.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';
import 'package:patroli/features/visits/domain/repositories/visit_repository.dart';

class VisitRepositoryImpl implements VisitRepository {
  final VisitRemoteDataSource _remoteDataSource;

  VisitRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, VisitEntity>> createVisit(
    VisitRequest request,
    int reportId,
  ) async {
    try {
      final model = await _remoteDataSource.createVisit(request, reportId);
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
