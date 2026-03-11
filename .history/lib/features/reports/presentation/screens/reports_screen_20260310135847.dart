import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';
import 'package:pos/features/reports/widgets/reports_card.dart';
import 'package:pos/features/reports/widgets/reports_shimmer.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late final PagingController<int, ReportsEntity> _pagingController;

  Future<List<ReportsEntity>> _fetchReports(int pageKey) async {
    final notifier = ref.read(reportsStateProvider.notifier);
    
    return await notifier.getReports(
      limit: 5,
      page: pageKey,
      pagination: 1,
    );
  }

  @override
  void initState() {
    super.initState();
    
    _pagingController = PagingController<int, ReportsEntity>(
      getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchReports,
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final reportsState = ref.watch(reportsStateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color.surface,
        surfaceTintColor: color.surface,
        title: const Text('Daftar Laporan'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: CustomScrollView(
          slivers: [
            PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) => PagedSliverList<int, ReportsEntity>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<ReportsEntity>(
                  firstPageProgressIndicatorBuilder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ReportCardShimmer(),
                        ReportCardShimmer(),
                        ReportCardShimmer(),
                      ],
                    );
                  },
                  newPageProgressIndicatorBuilder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ReportCardShimmer(),
                      ],
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.folder_open,
                              size: 64,
                              color: color.outline,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada laporan',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: color.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Mulai patroli dan buat laporan pertama Anda',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: color.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.danger, size: 64, color: color.error),
                          const SizedBox(height: 16),
                          Text('Terjadi Kesalahan',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: color.error,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (reportsState.errorMessage != null) ...[
                            Text(reportsState.errorMessage!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: color.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 16),
                          AppIconButton(
                            onPressed: () => _pagingController.refresh(),
                            icon: const Icon(Iconsax.refresh),
                            label: 'Coba Lagi',
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemBuilder: (context, report, index) {
                    return ReportCard(
                      report: report,
                      onTap: () {
                        // Navigate to report detail
                        // context.push(AppConstants.reportDetailRoute(report.id));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}