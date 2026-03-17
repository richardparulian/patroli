import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';

abstract class CheckInRepository {
  Future<Either<Failure, CheckInEntity>> createCheckIn(CheckInRequest request);
}
