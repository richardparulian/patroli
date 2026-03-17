import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class UploadFileState {
  final PreSignCreateEntity? presign;

  const UploadFileState({this.presign});
}

class UploadFileNotifier extends Notifier<ResultState<PreSignCreateEntity?>> {
  @override
  ResultState<PreSignCreateEntity?> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      final result = await ref.read(preSignUploadServiceProvider).createAndUpload(
        filename: filename,
        image: image,
      );
      final presign = result.dataOrThrow;

      state = Success(presign);
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));

    }
  }
}

final uploadFileProvider = NotifierProvider.autoDispose<UploadFileNotifier, ResultState<PreSignCreateEntity?>>(UploadFileNotifier.new);