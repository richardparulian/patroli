import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/reports/domain/entities/reports_count.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/providers/reports_di_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_count_provider.g.dart';

@riverpod
class CountReports extends _$CountReports {
  @override
  ResultState<ReportsCount> build() => const Idle();

  Future<void> fetchCount() async {
    state = const Loading();

    final reportsUseCase = ref.read(reportsUseCaseProvider);
    final result = await reportsUseCase(ReportsParams(pagination: 0));

    result.fold(
      (failure) => state = Error(failure.message),
      (reports) {
        final total = reports.length;
        final byStatus = reports.where((r) => r.statusValue == 1).length;

        state = Success(
          ReportsCount(
            total: total,
            byStatus: byStatus,
          ),
        );
      },
    );
  }
}