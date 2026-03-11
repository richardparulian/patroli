import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/repositories/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource _remoteDataSource;

  ReportsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ReportsEntity>>> getReports({required int page, required int limit}) async {
    try {
      final models = await _remoteDataSource.fetchReports(page: page, limit: limit);
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch reportss'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, int>> countReports({required int status}) async {
    try {
      final models = await _remoteDataSource.countReports(status: status);
      return Right(models);
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

// Provider
final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final remoteDataSource = ref.watch(reportsRemoteDataSourceProvider);
  return ReportsRepositoryImpl(remoteDataSource);
});
