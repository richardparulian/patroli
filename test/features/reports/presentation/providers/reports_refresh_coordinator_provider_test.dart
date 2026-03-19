import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/reports/application/coordinators/reports_refresh_coordinator_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_dashboard_summary.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/providers/reports_dashboard_flow_provider.dart';
import 'package:patroli/features/reports/presentation/providers/reports_flow_provider.dart';

class TestReportsFlowNotifier extends ReportsFlowNotifier {
  TestReportsFlowNotifier({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  ReportsFlowState build() {
    final pagingController = PagingController<int, ReportsEntity>(
      getNextPageKey: (_) => null,
      fetchPage: (_) async => const <ReportsEntity>[],
    );
    ref.onDispose(pagingController.dispose);
    return ReportsFlowState(pagingController: pagingController);
  }

  @override
  void refresh() {
    onRefresh();
  }
}

class TestReportsDashboardFlowNotifier extends ReportsDashboardFlowNotifier {
  TestReportsDashboardFlowNotifier({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  ReportsDashboardFlowState build() =>
      ReportsDashboardFlowState(summaryState: Idle<ReportsDashboardSummary>());

  @override
  Future<void> refresh() async {
    onRefresh();
  }
}

void main() {
  test('refreshReportsAndDashboard refreshes both flows', () async {
    var reportsRefreshCalls = 0;
    var dashboardRefreshCalls = 0;

    final container = ProviderContainer(
      overrides: [
        reportsFlowProvider.overrideWith(
          () => TestReportsFlowNotifier(onRefresh: () => reportsRefreshCalls++),
        ),
        reportsDashboardFlowProvider.overrideWith(
          () => TestReportsDashboardFlowNotifier(
            onRefresh: () => dashboardRefreshCalls++,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final coordinator = container.read(reportsRefreshCoordinatorProvider);
    await coordinator.refreshReportsAndDashboard();

    expect(reportsRefreshCalls, 1);
    expect(dashboardRefreshCalls, 1);
  });

  test('refreshDashboardOnly refreshes dashboard flow only', () async {
    var reportsRefreshCalls = 0;
    var dashboardRefreshCalls = 0;

    final container = ProviderContainer(
      overrides: [
        reportsFlowProvider.overrideWith(
          () => TestReportsFlowNotifier(onRefresh: () => reportsRefreshCalls++),
        ),
        reportsDashboardFlowProvider.overrideWith(
          () => TestReportsDashboardFlowNotifier(
            onRefresh: () => dashboardRefreshCalls++,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final coordinator = container.read(reportsRefreshCoordinatorProvider);
    await coordinator.refreshDashboardOnly();

    expect(reportsRefreshCalls, 0);
    expect(dashboardRefreshCalls, 1);
  });

  test('refreshReportsOnly refreshes reports flow only', () {
    var reportsRefreshCalls = 0;
    var dashboardRefreshCalls = 0;

    final container = ProviderContainer(
      overrides: [
        reportsFlowProvider.overrideWith(
          () => TestReportsFlowNotifier(onRefresh: () => reportsRefreshCalls++),
        ),
        reportsDashboardFlowProvider.overrideWith(
          () => TestReportsDashboardFlowNotifier(
            onRefresh: () => dashboardRefreshCalls++,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final coordinator = container.read(reportsRefreshCoordinatorProvider);
    coordinator.refreshReportsOnly();

    expect(reportsRefreshCalls, 1);
    expect(dashboardRefreshCalls, 0);
  });
}
