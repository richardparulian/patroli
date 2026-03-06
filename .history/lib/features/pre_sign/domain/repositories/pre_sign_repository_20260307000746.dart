import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/pre_sign_entity.dart';

abstract class PreSignRepository {
  Future<Either<Failure, List<PreSignEntity>>> getPreSigns();
  Future<Either<Failure, PreSignEntity>> getPreSign(int id);
}
