import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';

class UploadFileNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      final presign = (await _createPresign(filename)).dataOrThrow;

      (await _uploadImage(presign.url, image)).dataOrThrow;
      // (await _callCheckIn(branchId: branchId, imageUrl: presign.fileUrl ?? '')).dataOrThrow;

      state = const Success(null);
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));

    }
  }

  Future<ResultState<PreSignCreateEntity>> _createPresign(String filename) async {
    final notifier = ref.read(preSignCreateProvider.notifier);

    await notifier.createPreSign(
      request: PreSignCreateRequest(filename: filename),
    );

    final state = ref.read(preSignCreateProvider);

    if (state.hasError) {
      return const Error('Terjadi kesalahan saat membuat presigned URL');
    }

    final presign = state.value;

    if (presign == null) {
      return const Error('Presigned URL tidak ditemukan');
    }

    return Success(presign);
  }

  Future<ResultState<void>> _uploadImage(String? url, XFile image) async {
    if (url == null) {
      return const Error('Presigned URL tidak ditemukan');
    }

    final notifier = ref.read(preSignUpdateProvider.notifier);

    await notifier.updatePreSign(
      url: url,
      image: image,
    );

    final state = ref.read(preSignUpdateProvider);

    if (state.hasError) {
      return const Error('Terjadi kesalahan saat upload foto');
    }

    return const Success(null);
  }
}

final uploadFileProvider = NotifierProvider<UploadFileNotifier, ResultState<void>>(UploadFileNotifier.new);