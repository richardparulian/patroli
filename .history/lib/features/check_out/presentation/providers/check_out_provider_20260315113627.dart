import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_out/application/services/check_out_submission_service.dart';

class CheckOutNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckOut({required XFile image, required String filename, required int branchId, required int reportId}) async {
    state = const Loading();
    state = await ref.read(checkOutSubmissionServiceProvider).submit(
      image: image,
      filename: filename,
      branchId: branchId,
      reportId: reportId,
    );
  }
}

final checkOutProvider = NotifierProvider<CheckOutNotifier, ResultState<void>>(CheckOutNotifier.new);