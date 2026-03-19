import 'package:patroli/app/localization/localized_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class CheckInSelfieUploadNotifier
    extends Notifier<ResultState<PreSignCreateEntity?>> {
  @override
  ResultState<PreSignCreateEntity?> build() {
    return const Idle();
  }

  void reset() {
    state = const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> uploadSelfie({
    required XFile image,
    required String filename,
  }) async {
    try {
      final result = await ref
          .read(preSignUploadServiceProvider)
          .createAndUpload(filename: filename, image: image);
      final presign = result.dataOrThrow;

      state = Success(presign);
    } catch (e) {
      state = Error(localizeException(ref, e));
    }
  }
}

final checkInSelfieUploadProvider =
    NotifierProvider.autoDispose<
      CheckInSelfieUploadNotifier,
      ResultState<PreSignCreateEntity?>
    >(CheckInSelfieUploadNotifier.new);
