import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/pre_sign_entity.dart';

abstract class PreSignRepository {
  Future<Either<Failure, PreSignEntity>> getPreSign(int id);
}
