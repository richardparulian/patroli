import 'package:image_picker/image_picker.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/providers/check_out_di_provider.dart';
import 'package:patroli/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:patroli/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_out_submission_service.g.dart';

class CheckOutSubmissionService {
  CheckOutSubmissionService(this._checkOutUseCase, this._preSignUploadService);

  final CreateCheckOutUseCase _checkOutUseCase;
  final PreSignUploadService _preSignUploadService;

  Future<ResultState<void>> submit({
    required XFile image,
    required String filename,
    required int branchId,
    required int reportId,
  }) async {
    try {
      final uploadResult = await _preSignUploadService.createAndUpload(
        filename: filename,
        image: image,
      );
      final presign = uploadResult.dataOrThrow;

      final result = await _checkOutUseCase(
        CreateCheckOutParams(
          reportId: reportId,
          request: CheckOutRequest(
            branchId: branchId,
            selfieCheckOut: presign.fileUrl ?? '',
          ),
        ),
      );

      return result.fold(
        (failure) => Error(failure.message),
        (_) => const Success(null),
      );
    } catch (e) {
      return Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

@riverpod
CheckOutSubmissionService checkOutSubmissionService(Ref ref) {
  return CheckOutSubmissionService(
    ref.read(checkOutUseCaseProvider),
    ref.read(preSignUploadServiceProvider),
  );
}
