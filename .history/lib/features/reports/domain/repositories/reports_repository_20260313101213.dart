import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<ReportsEntity>>> getReports({int? page, int? perPage, int? withPagination});
}
