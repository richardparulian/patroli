import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/usecases/get_check_ins_use_case.dart';
import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';

class CheckInController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> checkIn({required CheckInRequest request}) async {
    state = const AsyncLoading();

    final checkInUseCase = ref.read(checkInUseCaseProvider);
    final result = await checkInUseCase(CreateCheckInParams(request: request));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (qrcode) => AsyncData(null),
    );
  }
}

final checkInProvider = AsyncNotifierProvider<CheckInController, void>(CheckInController.new);
