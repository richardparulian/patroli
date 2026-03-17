import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/repositories/reports_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_repository_impl.g.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource _remoteDataSource;

  ReportsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ReportsEntity>>> getReports({int? page, int? limit, int? pagination}) async {
    try {
      final result = await _remoteDataSource.fetchReports(page: page, limit: limit, pagination: pagination);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }   
}

@riverpod
ReportsRepository reportsRepository(Ref ref) {
  final remoteDataSource = ref.watch(reportsRemoteDataSourceProvider);
  return ReportsRepositoryImpl(remoteDataSource);
}
