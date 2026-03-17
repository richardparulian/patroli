import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/repositories/reports_repository.dart';

// :: Parameters for login use case
class ReportsParams extends Equatable {
  final int? page;
  final int? limit;
  final int? pagination;

  const ReportsParams({
    this.page,
    this.limit,
    this.pagination,
  });

  @override
  List<Object?> get props => [page, limit, pagination];
}

class ReportsUseCase implements UseCase<List<ReportsEntity>, ReportsParams> {
  final ReportsRepository _repository;

  ReportsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ReportsEntity>>> call(ReportsParams params) {
    // :: Fetch reports
    return _repository.getReports(page: params.page, limit: params.limit, pagination: params.pagination); 
  }
}
