import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/providers/reports_fetch_provider.dart';
import 'package:patroli/features/reports/presentation/providers/reports_paging_provider.dart';
import 'package:patroli/features/reports/widgets/reports_card.dart';
import 'package:patroli/features/reports/widgets/reports_shimmer.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(reportPagingProvider).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final reportController = ref.watch(reportsFetchProvider);
    final pagingController = ref.watch(reportPagingProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: color.surface,
        surfaceTintColor: color.surface,
        title: const Text('Daftar Laporan'),
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => ref.read(reportPagingProvider).refresh()),
        child: CustomScrollView(
          slivers: [
            PagingListener(
              controller: pagingController,
              builder: (context, state, fetchNextPage) {
                final items = state.items ?? [];

                return PagedSliverList<int, ReportsEntity>(
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
                          const SizedBox(height: 10),
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
                              Icon(Iconsax.folder_open, size: 64, color: color.outline),
                              const SizedBox(height: 16),
                              Text('Belum ada laporan',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: color.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Mulai patroli dan buat laporan pertama Anda',
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
                            if (reportController.errorMessage != null) ...[
                              Text(reportController.errorMessage!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: color.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            const SizedBox(height: 16),
                            AppIconButton(
                              onPressed: () => ref.read(reportPagingProvider).refresh(),
                              icon: const Icon(Iconsax.refresh),
                              label: 'Coba Lagi',
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (context, report, index) {
                      final isLast = index == items.length - 1;

                      return Column(
                        children: [
                          ReportCard(
                            report: report,
                            onTap: () => context.push(AppRoutes.reportDetail, extra: report),
                          ),
                          if (isLast) const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}