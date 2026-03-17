import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_in/application/services/check_in_submission_service.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';

class CheckInNotifier extends Notifier<ResultState<CheckInEntity>> {
  @override
  ResultState<CheckInEntity> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> callCheckIn({required int branchId, required String imageUrl}) async {
    state = const Loading();
    state = await ref.read(checkInSubmissionServiceProvider).submit(
      branchId: branchId,
      imageUrl: imageUrl,
    );
  }
}

final checkInProvider = NotifierProvider<CheckInNotifier, ResultState<CheckInEntity>>(CheckInNotifier.new);