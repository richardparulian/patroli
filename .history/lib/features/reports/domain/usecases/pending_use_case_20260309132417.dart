import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/repositories/reports_repository.dart';

// :: Parameters for login use case
class PendingParams extends Equatable {
  final int pagination;

  const PendingParams({
    required this.pagination,
  });

  @override
  List<Object?> get props => [pagination];
}

class PendingUseCase implements UseCase<int, PendingParams> {
  final ReportsRepository _repository;

  PendingUseCase(this._repository);

  @override
  Future<Either<Failure, int>> call(PendingParams params) {
    // :: Count pending reports
    return _repository.countReports(pagination: params.pagination); 
  }
}
