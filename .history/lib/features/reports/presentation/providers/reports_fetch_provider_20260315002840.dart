import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_fetch_provider.g.dart';

@riverpod
class ReportsFetch extends _$ReportsFetch {
  @override
  ReportsState build() {
    return const ReportsState();
  }

  void setCarouselIndex(int reportId, int index) {
    final updated = Map<int, int>.from(state.carouselIndexes);
    updated[reportId] = index;

    state = state.copyWith(carouselIndexes: updated);
  }

  void onSuccessReports(
    List<ReportsEntity> newReports, {
    required int pageSize,
    bool isLoadMore = false,
  }) {
    final updatedReports = isLoadMore ? [...state.reports, ...newReports] : newReports;
    final hasReachedMax = newReports.length < pageSize;

    state = state.copyWith(
      errorMessage: null,
      reports: updatedReports,
      hasReachedMax: hasReachedMax,
    );
  }

  void clear() {
    state = const ReportsState();
  }

  Future<List<ReportsEntity>> getReports({int? page, int? limit, int? pagination}) async {
    final reportsUseCase = ref.read(reportsUseCaseProvider);
    final pageSize = limit ?? 5;

    final result = await reportsUseCase(
      ReportsParams(
        page: page,
        limit: limit,
        pagination: pagination,
      ),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
        throw Exception(failure.message);
      },
      (response) {
        final isLoadMore = page != null && page > 1;
        onSuccessReports(
          response,
          pageSize: pageSize,
          isLoadMore: isLoadMore,
        );
        return response;
      },
    );
  }
}