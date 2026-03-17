import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:patroli/features/check_out/domain/entities/check_out_entity.dart';

abstract class CheckOutRepository {
  Future<Either<Failure, CheckOutEntity>> createCheckOut(CheckOutRequest request, int reportId);
}
