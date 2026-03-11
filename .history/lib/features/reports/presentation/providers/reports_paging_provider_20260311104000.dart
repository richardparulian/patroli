import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'reports_fetch_provider.dart'; // provider untuk fetch reports

/// Provider untuk PagingController
final reportPagingControllerProvider =
    Provider<PagingController<int, ReportsEntity>>((ref) {
  final pagingController = PagingController<int, ReportsEntity>(
    getNextPageKey: (state) {
      // Misal gunakan state.lastPageIsEmpty untuk logika stop
      return state.lastPageIsEmpty ? null : state.nextIntPageKey;
    },
    fetchPage: (pageKey) async {
      final notifier = ref.read(reportsStateProvider.notifier);
      final reports = await notifier.getReports(
        page: pageKey,
        limit: 5,
        pagination: 1,
      );
      return reports;
    },
  );

  // Opsional: kalau perlu dispose controller saat provider di-unwatch
  ref.onDispose(() => pagingController.dispose());

  return pagingController;
});