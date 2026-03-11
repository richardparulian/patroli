import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<ReportsEntity>>> getReports(int page, int limit);
  Future<Either<Failure, ReportsEntity>> countReports(int id);
}
