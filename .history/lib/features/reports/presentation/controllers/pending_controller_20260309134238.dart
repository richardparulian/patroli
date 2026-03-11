import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/usecases/pending_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class PendingController extends AsyncNotifier<int?> {
  @override
  Future<int?> build() async => null;

  Future<void> getPending({required int pagination}) async {
    state = const AsyncLoading();

    final pendingUseCase = ref.read(pendingUseCaseProvider);

    final result = await pendingUseCase(
      PendingParams(pagination: pagination),
    );

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (response) => state = AsyncData(response),
    );
  }       
}

final pendingProvider = AsyncNotifierProvider<PendingController, int?>(PendingController.new);