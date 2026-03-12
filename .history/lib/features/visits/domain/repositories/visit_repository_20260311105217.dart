import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';

abstract class VisitRepository {
  Future<Either<Failure, VisitEntity>> createVisit(VisitRequest request, int reportId);
}
