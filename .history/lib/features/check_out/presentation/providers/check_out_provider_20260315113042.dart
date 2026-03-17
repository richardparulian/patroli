import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_out/application/providers/check_out_di_provider.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:pos/features/pre_sign/application/services/pre_sign_upload_service.dart';

class CheckOutNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckOut({required XFile image, required String filename, required int branchId, required int reportId}) async {
    try {
      final uploadResult = await ref.read(preSignUploadServiceProvider).createAndUpload(
        filename: filename,
        image: image,
      );
      final presign = uploadResult.dataOrThrow;
      (await _callCheckOut(branchId: branchId, imageUrl: presign.fileUrl ?? '', reportId: reportId)).dataOrThrow;

      state = const Success(null);
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));

    }
  }

  Future<ResultState<void>> _callCheckOut({required int branchId, required String imageUrl, required int reportId}) async {
    final checkOutUseCase = ref.read(checkOutUseCaseProvider);

    final result = await checkOutUseCase(
      CreateCheckOutParams(
        reportId: reportId,
        request: CheckOutRequest(
          branchId: branchId,
          selfieCheckOut: imageUrl,
        ),
      ),
    );

    return result.fold(
      (failure) => Error(failure.message),
      (_) => const Success(null),
    );
  }
}

final checkOutProvider = NotifierProvider<CheckOutNotifier, ResultState<void>>(CheckOutNotifier.new);