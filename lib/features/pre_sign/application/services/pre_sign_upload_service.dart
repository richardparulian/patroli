import 'package:image_picker/image_picker.dart';
import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/pre_sign/application/providers/pre_sign_di_provider.dart';
import 'package:patroli/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_update_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pre_sign_upload_service.g.dart';

class PreSignUploadService {
  PreSignUploadService(this.ref, this._createUseCase, this._updateUseCase);

  final Ref ref;
  final PreSignCreateUseCase _createUseCase;
  final PreSignUpdateUseCase _updateUseCase;

  Future<ResultState<PreSignCreateEntity>> createAndUpload({
    required String filename,
    required XFile image,
  }) async {
    try {
      final createResult = await _createUseCase(
        PreSignCreateParams(request: PreSignCreateRequest(filename: filename)),
      );

      final presign = createResult.fold<PreSignCreateEntity?>(
        (failure) => throw ServerException(message: failure.message),
        (entity) => entity,
      );

      if (presign == null) {
        return Error(localizeKey(ref, 'presigned_url_not_found'));
      }

      final url = presign.url;
      if (url == null || url.isEmpty) {
        return Error(localizeKey(ref, 'presigned_url_not_found'));
      }

      final uploadResult = await _updateUseCase(
        PreSignUpdateParams(url: url, image: image),
      );

      return uploadResult.fold(
        (failure) => Error(localizeMessage(ref, failure.message)),
        (_) => Success(presign),
      );
    } catch (e) {
      return Error(localizeException(ref, e));
    }
  }
}

@Riverpod(keepAlive: true)
PreSignUploadService preSignUploadService(Ref ref) {
  return PreSignUploadService(
    ref,
    ref.read(preSignCreateUseCaseProvider),
    ref.read(preSignUpdateUseCaseProvider),
  );
}
