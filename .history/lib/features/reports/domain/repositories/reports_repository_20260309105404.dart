import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<ReportsEntity>>> getReportss();
  Future<Either<Failure, ReportsEntity>> getReports(int id);
}
