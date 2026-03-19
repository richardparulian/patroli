import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/providers/check_out_di_provider.dart';
import 'package:patroli/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:patroli/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_out_submission_service.g.dart';

class CheckOutSubmissionService {
  CheckOutSubmissionService(this.ref, this._checkOutUseCase);

  final Ref ref;
  final CreateCheckOutUseCase _checkOutUseCase;

  Future<ResultState<void>> submit({
    required int branchId,
    required int reportId,
    required String imageUrl,
  }) async {
    try {
      final result = await _checkOutUseCase(
        CreateCheckOutParams(
          reportId: reportId,
          request: CheckOutRequest(
            branchId: branchId,
            selfieCheckOut: imageUrl,
          ),
        ),
      );

      return result.fold(
        (failure) => Error(localizeMessage(ref, failure.message)),
        (_) => const Success(null),
      );
    } catch (e) {
      return Error(localizeException(ref, e));
    }
  }
}

@riverpod
CheckOutSubmissionService checkOutSubmissionService(Ref ref) {
  return CheckOutSubmissionService(ref, ref.read(checkOutUseCaseProvider));
}
