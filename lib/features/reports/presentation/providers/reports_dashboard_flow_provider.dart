import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/reports/application/providers/reports_di_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_dashboard_summary.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';

class ReportsDashboardFlowState {
  const ReportsDashboardFlowState({
    this.summaryState = const Idle<ReportsDashboardSummary>(),
  });

  final ResultState<ReportsDashboardSummary> summaryState;

  ReportsDashboardFlowState copyWith({
    ResultState<ReportsDashboardSummary>? summaryState,
  }) {
    return ReportsDashboardFlowState(
      summaryState: summaryState ?? this.summaryState,
    );
  }

  bool get isLoading => summaryState.isLoading;
  ReportsDashboardSummary? get summary => summaryState.dataOrNull;
  String? get errorMessage => summaryState.errorMessage;
}

class ReportsDashboardFlowNotifier extends Notifier<ReportsDashboardFlowState> {
  @override
  ReportsDashboardFlowState build() => const ReportsDashboardFlowState();

  Future<void> refresh() async {
    state = state.copyWith(
      summaryState: const Loading<ReportsDashboardSummary>(),
    );

    final reportsUseCase = ref.read(reportsUseCaseProvider);
    final result = await reportsUseCase(ReportsParams(pagination: 0));

    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(
        summaryState: Error<ReportsDashboardSummary>(
          localizeMessage(ref, failure.message),
        ),
      ),
      (reports) {
        final total = reports.length;
        final byStatus = reports.where((r) => r.statusValue == 1).length;

        state = state.copyWith(
          summaryState: Success(
            ReportsDashboardSummary(total: total, byStatus: byStatus),
          ),
        );
      },
    );
  }
}

final reportsDashboardFlowProvider =
    NotifierProvider.autoDispose<
      ReportsDashboardFlowNotifier,
      ReportsDashboardFlowState
    >(ReportsDashboardFlowNotifier.new);
