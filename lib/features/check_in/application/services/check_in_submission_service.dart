import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/features/check_in/application/providers/check_in_di_provider.dart';
import 'package:patroli/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_submission_service.g.dart';

class CheckInSubmissionService {
  CheckInSubmissionService(this.ref);

  final Ref ref;

  Future<ResultState<CheckInEntity>> submit({
    required int branchId,
    required String imageUrl,
  }) async {
    try {
      final checkInUseCase = ref.read(checkInUseCaseProvider);
      final result = await checkInUseCase(
        CreateCheckInParams(
          request: CheckInRequest(branchId: branchId, selfieCheckIn: imageUrl),
        ),
      );

      return result.fold(
        (failure) => Error(localizeMessage(ref, failure.message)),
        (checkInData) => Success(checkInData),
      );
    } catch (e) {
      return Error(localizeException(ref, e));
    }
  }
}

@riverpod
CheckInSubmissionService checkInSubmissionService(Ref ref) {
  return CheckInSubmissionService(ref);
}
