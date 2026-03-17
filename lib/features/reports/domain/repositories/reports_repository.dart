import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<ReportsEntity>>> getReports({int? page, int? limit, int? pagination});
}
