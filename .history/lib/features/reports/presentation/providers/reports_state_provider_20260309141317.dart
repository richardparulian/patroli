import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class ReportsState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int countPending;
  final String? errorMessage;

  const ReportsState({
    this.isError = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.countPending = 0,
    this.errorMessage,
  });

  ReportsState copyWith({
    bool? isError,
    bool? isLoading, 
    bool? isSuccess, 
    int? countPending,
    String? errorMessage, 
  }) {
    return ReportsState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      countPending: countPending ?? this.countPending,
      errorMessage: errorMessage,
    );
  }
}

class ReportsNotifier extends Notifier<ReportsState> {
  @override
  ReportsState build() {
    return const ReportsState();
  }

  void setError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setErrorMessage(String message) {
    state = state.copyWith(
      isError: true,
      isLoading: false,
      errorMessage: message,
    );
  }

  void onSuccess(List<ReportsEntity> reports) {
    final count = reports.where((r) => r.statusValue == 1).length;

    state = state.copyWith(
      isLoading: false,
      isError: false,
      isSuccess: true,
      countPending: count,
    );
  }

  void clear() {
    state = const ReportsState();
  }

  Future<void> getReports({int? page, int? limit, int? pagination}) async {
    state = state.copyWith(isLoading: true);

    final reportsUseCase = ref.read(reportsUseCaseProvider);
    final result = await reportsUseCase(
      ReportsParams(
        page: page ?? 1, 
        limit: limit ?? 10,
      ),
    );

    result.fold(
      (failure) => setErrorMessage(failure.message),
      (response) => onSuccess(response),
    );
  }
}

final reportsStateProvider = NotifierProvider<ReportsNotifier, ReportsState>(ReportsNotifier.new);
