import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class ReportsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> getReports({required int page, required int limit}) async {
    state = const AsyncLoading();

    final reportsUseCase = ref.read(reportsUseCaseProvider);

    final result = await reportsUseCase(
      ReportsParams(page: page, limit: limit),
    );

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (user) {
        ref.read(authSessionProvider.notifier).state = user;
        state = const AsyncData(null);
      },
    );
  }
}

final reportsProvider = AsyncNotifierProvider<ReportsController, void>(ReportsController.new);