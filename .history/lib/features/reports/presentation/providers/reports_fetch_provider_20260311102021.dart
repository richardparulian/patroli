  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:pos/features/reports/domain/entities/reports_entity.dart';
  import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
  import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';
  import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

  class ReportsNotifier extends Notifier<ReportsState> {
    @override
    ReportsState build() {
      return const ReportsState();
    }

    void setCarouselIndex(int reportId, int index) {
      final updated = Map<int, int>.from(state.carouselIndexes);
      updated[reportId] = index;

      state = state.copyWith(carouselIndexes: updated);
    }

    void onSuccessReports(List<ReportsEntity> newReports, {bool isLoadMore = false}) {
      final updatedReports = isLoadMore ? [...state.reports, ...newReports] : newReports;
      final hasReachedMax = newReports.length < 10; 

      state = state.copyWith(
        reports: updatedReports,
        hasReachedMax: hasReachedMax,
      );
    }

    void clear() {
      state = const ReportsState();
    }

    Future<List<ReportsEntity>> getReports({int? page, int? limit, int? pagination}) async {
      final reportsUseCase = ref.read(reportsUseCaseProvider);

      final result = await reportsUseCase(
        ReportsParams(
          page: page,
          limit: limit,
          pagination: pagination,
        ),
      );

      return result.fold(
        (failure) => throw Exception(failure.message),
        (response) {
          final isLoadMore = page != null && page > 1;
          onSuccessReports(response, isLoadMore: isLoadMore);
          
          return response; 
        },
      );
    }

    Future<void> refresh() async {
      clear();
      await getReports(page: 1, limit: 5, pagination: 1);
    }
  }

  final reportsStateProvider = NotifierProvider<ReportsNotifier, ReportsState>(ReportsNotifier.new);