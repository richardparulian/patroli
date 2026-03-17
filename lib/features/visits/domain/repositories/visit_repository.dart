import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';

abstract class VisitRepository {
  Future<Either<Failure, VisitEntity>> createVisit(VisitRequest request, int reportId);
}
