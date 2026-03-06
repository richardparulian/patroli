import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';

abstract class PreSignRepository {
  Future<Either<Failure, PreSignEntity>> postPreSign(PreSignRequest request);
  Future<Either<Failure, PreSignEntity>> putPreSign(String url);
}
