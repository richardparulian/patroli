import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';

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

    try {
      final checkInUseCase = ref.read(checkInUseCaseProvider);

      final result = await checkInUseCase(CreateCheckInParams(
        request: CheckInRequest(branchId: branchId, selfieCheckIn: imageUrl),
      ));

      result.fold(
        (failure) => state = Error(failure.message),
        (checkInData) => state = Success(checkInData),
      );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final checkInProvider = NotifierProvider<CheckInNotifier, ResultState<void>>(CheckInNotifier.new);