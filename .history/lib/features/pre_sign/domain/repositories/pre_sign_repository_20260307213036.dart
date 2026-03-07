import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_response_entity.dart';

abstract class PreSignRepository {
  Future<Either<Failure, PreSignEntity>> postPreSign(PreSignRequest request);
  Future<Either<Failure, PreSignResponseEntity>> putPreSign(String url, XFile image);
}
