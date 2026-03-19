import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/services/check_out_submission_service.dart';

class CheckOutNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckOut({
    required int branchId,
    required int reportId,
    required String imageUrl,
  }) async {
    state = const Loading();
    state = await ref
        .read(checkOutSubmissionServiceProvider)
        .submit(branchId: branchId, reportId: reportId, imageUrl: imageUrl);
  }
}

final checkOutProvider = NotifierProvider<CheckOutNotifier, ResultState<void>>(
  CheckOutNotifier.new,
);
