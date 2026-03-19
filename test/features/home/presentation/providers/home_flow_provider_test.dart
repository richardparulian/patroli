import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:patroli/features/home/presentation/providers/home_flow_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_dashboard_summary.dart';
import 'package:patroli/features/reports/presentation/providers/reports_dashboard_flow_provider.dart';

class TestAuthLogout extends AuthLogout {
  TestAuthLogout({this.onRunLogout});

  final VoidCallback? onRunLogout;

  @override
  ResultState<void> build() => const Idle<void>();

  @override
  Future<ResultState<void>> runLogout() async {
    onRunLogout?.call();
    state = const Success<void>(null);
    return state;
  }
}

class TestReportsDashboardFlow extends ReportsDashboardFlowNotifier {
  TestReportsDashboardFlow({
    this.initialState = const Idle<ReportsDashboardSummary>(),
    this.onRefresh,
  });

  final ResultState<ReportsDashboardSummary> initialState;
  final VoidCallback? onRefresh;

  @override
  ReportsDashboardFlowState build() =>
      ReportsDashboardFlowState(summaryState: initialState);

  @override
  Future<void> refresh() async {
    onRefresh?.call();
  }
}

void main() {
  test('refreshDashboard delegates to reportsDashboardFlowProvider', () async {
    var fetchCalls = 0;

    final container = ProviderContainer(
      overrides: [
        reportsDashboardFlowProvider.overrideWith(
          () => TestReportsDashboardFlow(onRefresh: () => fetchCalls++),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(homeFlowProvider.notifier).refreshDashboard();

    expect(fetchCalls, 1);
  });

  test('logout delegates to authLogoutProvider', () async {
    var logoutCalls = 0;

    final container = ProviderContainer(
      overrides: [
        authLogoutProvider.overrideWith(
          () => TestAuthLogout(onRunLogout: () => logoutCalls++),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(homeFlowProvider.notifier).logout();

    expect(result, isA<Success<void>>());
    expect(logoutCalls, 1);
  });
}
