// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pos/core/extensions/result_state_extension.dart';
// import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
// import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

// class CountReportsNotifier extends Notifier<ResultState<int>> {
//   @override
//   ResultState<int> build() => const Idle();

//   Future<void> fetchCount() async {
//     state = const Loading();

//     try {
//       final reportsUseCase = ref.read(reportsUseCaseProvider);
//       final result = await reportsUseCase(ReportsParams(pagination: 0));

//       result.fold(
//         (failure) => state = Error(failure.message),
//         (reports) => state = Success(reports.length),
//       );
//     } catch (e) {
//       state = Error(e.toString());
//     }
//   }
// }

// final countReportsProvider = NotifierProvider<CountReportsNotifier, ResultState<int>>(CountReportsNotifier.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/reports/domain/entities/reports_count.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class CountReportsNotifier extends Notifier<ResultState<ReportsCount>> {
  @override
  ResultState<ReportsCount> build() => const Idle();

  Future<void> fetchCount() async {
    state = const Loading();

    try {
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
    } catch (e) {
      state = Error(e.toString());
    }
  }

  void reset() {
    state = const Idle();
  }
}

final countReportsProvider = NotifierProvider<CountReportsNotifier, ResultState<ReportsCount>>(CountReportsNotifier.new);