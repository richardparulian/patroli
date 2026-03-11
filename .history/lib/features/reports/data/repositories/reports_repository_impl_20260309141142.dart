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
  Future<Either<Failure, List<ReportsEntity>>> getReports({int? page, int? limit, int? pagination}) async {
    try {
      final result = await _remoteDataSource.fetchReports(page: page, limit: limit, pagination: pagination);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch reportss'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }   
}

// Provider
final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final remoteDataSource = ref.watch(reportsRemoteDataSourceProvider);
  return ReportsRepositoryImpl(remoteDataSource);
});
