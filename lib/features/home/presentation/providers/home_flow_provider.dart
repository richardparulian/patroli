import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_dashboard_summary.dart';
import 'package:patroli/features/reports/presentation/providers/reports_dashboard_flow_provider.dart';

class HomeFlowState {
  const HomeFlowState({
    this.dashboardState = const Idle<ReportsDashboardSummary>(),
    this.logoutState = const Idle<void>(),
  });

  final ResultState<ReportsDashboardSummary> dashboardState;
  final ResultState<void> logoutState;

  bool get isRefreshingDashboard => dashboardState.isLoading;
  bool get isLoggingOut => logoutState.isLoading;
  bool get isBusy => isRefreshingDashboard || isLoggingOut;
}

class HomeFlowNotifier extends Notifier<HomeFlowState> {
  @override
  HomeFlowState build() {
    final dashboardState = ref.watch(
      reportsDashboardFlowProvider.select((s) => s.summaryState),
    );
    final logoutState = ref.watch(authLogoutProvider);

    return HomeFlowState(
      dashboardState: dashboardState,
      logoutState: logoutState,
    );
  }

  Future<void> refreshDashboard() async {
    await ref.read(reportsDashboardFlowProvider.notifier).refresh();
  }

  Future<ResultState<void>> logout() async {
    return ref.read(authLogoutProvider.notifier).runLogout();
  }
}

final homeFlowProvider =
    NotifierProvider.autoDispose<HomeFlowNotifier, HomeFlowState>(
      HomeFlowNotifier.new,
    );
