import 'package:patroli/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:patroli/features/reports/presentation/providers/reports_flow_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_refresh_coordinator_provider.g.dart';

class ReportsRefreshCoordinator {
  ReportsRefreshCoordinator(this.ref);

  final Ref ref;

  Future<void> refreshReportsAndDashboard() async {
    ref.read(reportsFlowProvider.notifier).refresh();
    await ref.read(countReportsProvider.notifier).fetchCount();
  }

  Future<void> refreshDashboardOnly() async {
    await ref.read(countReportsProvider.notifier).fetchCount();
  }

  void refreshReportsOnly() {
    ref.read(reportsFlowProvider.notifier).refresh();
  }
}

@riverpod
ReportsRefreshCoordinator reportsRefreshCoordinator(Ref ref) {
  return ReportsRefreshCoordinator(ref);
}
