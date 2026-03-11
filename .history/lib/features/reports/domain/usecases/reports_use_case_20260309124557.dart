import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/repositories/reports_repository.dart';

// :: Parameters for login use case
class ReportsParams extends Equatable {
  final int page;
  final int limit;

  const ReportsParams({
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [page, limit];
}

class ReportsUseCase implements UseCase<List<ReportsEntity>, ReportsParams> {
  final ReportsRepository _repository;

  ReportsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ReportsEntity>>> call(ReportsParams params) {
    // :: Fetch reports
    return _repository.getReports(page: params.page, limit: params.limit); 
  }
}
