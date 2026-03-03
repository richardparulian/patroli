import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/check_in_entity.dart';

abstract class CheckInRepository {
  Future<Either<Failure, List<CheckInEntity>>> getCheckIns();
  Future<Either<Failure, CheckInEntity>> getCheckIn(int id);
}
