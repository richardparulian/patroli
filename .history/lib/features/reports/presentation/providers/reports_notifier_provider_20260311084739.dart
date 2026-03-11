import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

// class ReportsState {
//   final bool isError;
//   final bool isLoading;
//   final bool isSuccess;
//   final int countByStatus;
//   final int totalReports;
//   final String? errorMessage;
//   final List<ReportsEntity> reports; 
//   final bool hasReachedMax;
//   final Map<int, int> carouselIndexes;

//   const ReportsState({
//     this.isError = false,
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.countByStatus = 0,
//     this.totalReports = 0,
//     this.errorMessage,
//     this.reports = const [],
//     this.hasReachedMax = false,
//     this.carouselIndexes = const {},
//   });

//   ReportsState copyWith({
//     bool? isError,
//     bool? isLoading, 
//     bool? isSuccess, 
//     int? countByStatus,
//     int? totalReports,
//     String? errorMessage, 
//     List<ReportsEntity>? reports,
//     bool? hasReachedMax,
//     Map<int, int>? carouselIndexes,
//   }) {
//     return ReportsState(
//       isError: isError ?? this.isError,
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       countByStatus: countByStatus ?? this.countByStatus,
//       totalReports: totalReports ?? this.totalReports,
//       errorMessage: errorMessage,
//       reports: reports ?? this.reports,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       carouselIndexes: carouselIndexes ?? this.carouselIndexes,
//     );
//   }
// }

// class ReportsNotifier extends Notifier<ReportsState> {
//   @override
//   ReportsState build() {
//     return const ReportsState();
//   }

//   void setError(bool isError) {
//     state = state.copyWith(isError: isError);
//   }

//   void setLoading(bool isLoading) {
//     state = state.copyWith(isLoading: isLoading);
//   }

//   void setErrorMessage(String message) {
//     state = state.copyWith(
//       isError: true,
//       isLoading: false,
//       errorMessage: message,
//     );
//   }

//   void setCarouselIndex(int reportId, int index) {
//     final updated = Map<int, int>.from(state.carouselIndexes);
//     updated[reportId] = index;

//     state = state.copyWith(carouselIndexes: updated);
//   }

//   void onSuccessCount(List<ReportsEntity> reports) {
//     final countByStatus = reports.where((r) => r.statusValue == 1).length;
//     final totalReports = reports.length;

//     state = state.copyWith(
//       isLoading: false,
//       isError: false,
//       isSuccess: true,
//       countByStatus: countByStatus,
//       totalReports: totalReports,
//     );
//   }

//   void onSuccessReports(List<ReportsEntity> newReports, {bool isLoadMore = false}) {
//     final updatedReports = isLoadMore ? [...state.reports, ...newReports] : newReports;
//     final hasReachedMax = newReports.length < 10; 

//     state = state.copyWith(
//       isLoading: false,
//       isError: false,
//       isSuccess: true,
//       reports: updatedReports,
//       hasReachedMax: hasReachedMax,
//     );
//   }

//   void clear() {
//     state = const ReportsState();
//   }

//   Future<void> countReports({int? page, int? limit, int? pagination}) async {
//     state = state.copyWith(isLoading: true);

//     final reportsUseCase = ref.read(reportsUseCaseProvider);
//     final result = await reportsUseCase(
//       ReportsParams(
//         pagination: pagination,
//       ),
//     );

//     result.fold(
//       (failure) => setErrorMessage(failure.message),
//       (response) => onSuccessCount(response),
//     );
//   }

//   Future<List<ReportsEntity>> getReports({int? page, int? limit, int? pagination}) async {
//     final reportsUseCase = ref.read(reportsUseCaseProvider);

//     final result = await reportsUseCase(
//       ReportsParams(
//         page: page,
//         limit: limit,
//         pagination: pagination,
//       ),
//     );

//     return result.fold(
//       (failure) => throw Exception(failure.message),
//       (response) {
//         final isLoadMore = page != null && page > 1;
//         onSuccessReports(response, isLoadMore: isLoadMore);
        
//         return response; 
//       },
//     );
//   }
// }

// final reportsStateProvider = NotifierProvider<ReportsNotifier, ReportsState>(ReportsNotifier.new);

class ReportsNotifier extends AsyncNotifier<ReportsState> {

  int _page = 1;
  final int _limit = 10;

  @override
  Future<ReportsState> build() async {
    final reports = await _fetchReports(page: 1);

    final count = reports.where((r) => r.statusValue == 1).length;

    return ReportsState(
      reports: reports,
      totalReports: reports.length,
      countByStatus: count,
      hasReachedMax: reports.length < _limit,
    );
  }

  Future<List<ReportsEntity>> _fetchReports({required int page}) async {
    final reportsUseCase = ref.read(reportsUseCaseProvider);

    final result = await reportsUseCase(
      ReportsParams(
        page: page,
        limit: _limit,
      ),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => response,
    );
  }

  Future<void> refresh() async {
    _page = 1;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final reports = await _fetchReports(page: 1);

      final count = reports.where((r) => r.statusValue == 1).length;

      return ReportsState(
        reports: reports,
        totalReports: reports.length,
        countByStatus: count,
        hasReachedMax: reports.length < _limit,
      );
    });
  }

  Future<void> loadMore() async {
    final current = state.value;

    if (current == null || current.hasReachedMax) return;

    _page++;

    final newReports = await _fetchReports(page: _page);

    final updated = [...current.reports, ...newReports];

    state = AsyncData(
      current.copyWith(
        reports: updated,
        hasReachedMax: newReports.length < _limit,
      ),
    );
  }

  void setCarouselIndex(int reportId, int index) {
    final current = state.value;
    if (current == null) return;

    final updated = Map<int, int>.from(current.carouselIndexes);
    updated[reportId] = index;

    state = AsyncData(
      current.copyWith(carouselIndexes: updated),
    );
  }
}

final reportsStateProvider = AsyncNotifierProvider<ReportsNotifier, ReportsState>(ReportsNotifier.new);
