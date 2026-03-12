import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';

class CheckInNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  Future<ResultState<void>> callCheckIn({required int branchId, required String imageUrl}) async {
    try {
      final checkInUseCase = ref.read(checkInUseCaseProvider);

      final result = await checkInUseCase(CreateCheckInParams(request: CheckInRequest(branchId: branchId, selfieCheckIn: imageUrl)));

      return result.fold(
        (failure) => Error(failure.message),
        (_) => const Success(null),
      );
    } catch (e) {
      return Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final checkInProvider = NotifierProvider<CheckInNotifier, ResultState<void>>(CheckInNotifier.new);