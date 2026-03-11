import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/repositories/reports_repository.dart';

// :: Parameters for get reports by id use case
class GetReportsByIdParams extends Equatable {
  final int id;

  const GetReportsByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetReportsByIdUseCase implements UseCase<ReportsEntity, GetReportsByIdParams> {
  final ReportsRepository _repository;

  GetReportsByIdUseCase(this._repository);

  @override
  Future<Either<Failure, ReportsEntity>> call(GetReportsByIdParams params) {
    return _repository.getReports(params.id);
  }
}
