import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:patroli/features/reports/application/services/reports_fetch_service.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';

class ReportsFlowState {
  const ReportsFlowState({
    required this.pagingController,
    this.errorMessage,
    this.carouselIndexes = const {},
  });

  final PagingController<int, ReportsEntity> pagingController;
  final String? errorMessage;
  final Map<int, int> carouselIndexes;

  ReportsFlowState copyWith({
    Object? errorMessage = _unset,
    Map<int, int>? carouselIndexes,
  }) {
    return ReportsFlowState(
      pagingController: pagingController,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      carouselIndexes: carouselIndexes ?? this.carouselIndexes,
    );
  }

  int carouselIndexFor(int reportId) => carouselIndexes[reportId] ?? 0;
}

const _unset = Object();

class ReportsPagingException implements Exception {
  ReportsPagingException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ReportsFlowNotifier extends Notifier<ReportsFlowState> {
  static const _pageSize = 5;

  @override
  ReportsFlowState build() {
    final pagingController = PagingController<int, ReportsEntity>(
      getNextPageKey: (state) {
        final pages = state.pages;
        if (pages == null || pages.isEmpty) {
          return 1;
        }

        final lastPage = pages.last;
        if (lastPage.length < _pageSize) {
          return null;
        }

        return state.nextIntPageKey;
      },
      fetchPage: _fetchPage,
    );

    ref.onDispose(pagingController.dispose);

    return ReportsFlowState(pagingController: pagingController);
  }

  Future<List<ReportsEntity>> _fetchPage(int pageKey) async {
    final reportsFetchService = ref.read(reportsFetchServiceProvider);

    try {
      final reports = await reportsFetchService.fetch(
        page: pageKey,
        limit: _pageSize,
        pagination: 1,
      );

      if (ref.mounted) {
        state = state.copyWith(errorMessage: null);
      }

      return reports;
    } on ReportsFetchException catch (e) {
      if (ref.mounted) {
        state = state.copyWith(errorMessage: e.message);
      }

      throw ReportsPagingException(e.message);
    }
  }

  void refresh() {
    state = state.copyWith(errorMessage: null, carouselIndexes: const {});
    state.pagingController.refresh();
  }

  void setCarouselIndex(int reportId, int index) {
    state = state.copyWith(
      carouselIndexes: {...state.carouselIndexes, reportId: index},
    );
  }

  void clearCarouselIndex(int reportId) {
    final updated = Map<int, int>.from(state.carouselIndexes);
    updated.remove(reportId);
    state = state.copyWith(carouselIndexes: updated);
  }
}

final reportsFlowProvider =
    NotifierProvider<ReportsFlowNotifier, ReportsFlowState>(
      ReportsFlowNotifier.new,
    );
