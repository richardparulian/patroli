import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'reports_fetch_provider.dart';

part 'reports_paging_provider.g.dart';

@riverpod
PagingController<int, ReportsEntity> reportPaging(Ref ref) {
  final pagingController = PagingController<int, ReportsEntity>(
    getNextPageKey: (state) {
      return state.lastPageIsEmpty ? null : state.nextIntPageKey;
    },
    fetchPage: (pageKey) async {
      final notifier = ref.read(reportsFetchProvider.notifier);
      final reports = await notifier.getReports(
        page: pageKey,
        limit: 5,
        pagination: 1,
      );
      return reports;
    },
  );

  ref.onDispose(() => pagingController.dispose());

  return pagingController;
}