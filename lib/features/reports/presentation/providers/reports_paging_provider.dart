import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'reports_fetch_provider.dart';

part 'reports_paging_provider.g.dart';

@Riverpod(keepAlive: true)
PagingController<int, ReportsEntity> reportPaging(Ref ref) {
  const pageSize = 5;

  final pagingController = PagingController<int, ReportsEntity>(
    getNextPageKey: (state) {
      final pages = state.pages;
      if (pages == null || pages.isEmpty) {
        return 1;
      }

      final lastPage = pages.last;
      if (lastPage.length < pageSize) {
        return null;
      }

      return state.nextIntPageKey;
    },
    fetchPage: (pageKey) async {
      final notifier = ref.read(reportsFetchProvider.notifier);
      final reports = await notifier.getReports(
        page: pageKey,
        limit: pageSize,
        pagination: 1,
      );
      return reports;
    },
  );


  return pagingController;
}