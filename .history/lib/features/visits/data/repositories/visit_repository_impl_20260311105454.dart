import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/check_out/data/datasources/check_out_remote_data_source.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';
import 'package:pos/features/check_out/domain/repositories/check_out_repository.dart';
import 'package:pos/features/visits/data/datasources/visit_remote_data_source.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';
import 'package:pos/features/visits/domain/repositories/visit_repository.dart'; 

class VisitRepositoryImpl implements VisitRepository {
  final VisitRemoteDataSource _remoteDataSource;

  VisitRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, VisitEntity>> createVisit(VisitRequest request, int reportId) async {
    try {
      final model = await _remoteDataSource.createVisit(request, reportId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  final remoteDataSource = ref.watch(visitRemoteDataSourceProvider);
  return VisitRepositoryImpl(remoteDataSource);
});
