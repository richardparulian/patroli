import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_update_entity.dart';

abstract class PreSignRepository {
  Future<Either<Failure, PreSignCreateEntity>> postPreSign(PreSignCreateRequest request);
  Future<Either<Failure, PreSignUpdateEntity>> putPreSign(String url, XFile image);
}
