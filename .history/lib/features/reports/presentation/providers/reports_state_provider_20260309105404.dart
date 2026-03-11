import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';

class ReportsListNotifier extends Notifier<AsyncValue<List<ReportsEntity>>> {
  @override
  AsyncValue<List<ReportsEntity>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadReportss() async {
    final controller = ref.read(reportsControllerProvider.notifier);

    final result = await controller.fetchReportss();

    result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
      (entities) {
        state = AsyncValue.data(entities);
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await loadReportss();
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

final reportsListProvider =
    NotifierProvider<ReportsListNotifier, AsyncValue<List<ReportsEntity>>>(
        ReportsListNotifier.new);
