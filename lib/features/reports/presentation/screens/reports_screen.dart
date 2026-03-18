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
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

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
        title: Text(context.tr('reports_title')),
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: ScreenUtil.sp(20),
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
                          SizedBox(height: ScreenUtil.sh(10)),
                        ],
                      );
                    },
                    noItemsFoundIndicatorBuilder: (_) {
                      return Center(
                        child: Padding(
                          padding: ScreenUtil.paddingFromDesign(all: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.folder_open, size: ScreenUtil.icon(64), color: color.outline),
                              SizedBox(height: ScreenUtil.sh(16)),
                              Text(context.tr('no_reports'),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: color.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: ScreenUtil.sh(8)),
                              Text(context.tr('start_first_report'),
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
                        padding: ScreenUtil.paddingFromDesign(all: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.danger, size: ScreenUtil.icon(64), color: color.error),
                            SizedBox(height: ScreenUtil.sh(16)),
                            Text(context.tr('error_occurred'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: color.error,
                              ),
                            ),
                            SizedBox(height: ScreenUtil.sh(8)),
                            if (reportController.errorMessage != null) ...[
                              Text(reportController.errorMessage!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: color.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            SizedBox(height: ScreenUtil.sh(16)),
                            AppIconButton(
                              onPressed: () => ref.read(reportPagingProvider).refresh(),
                              icon: const Icon(Iconsax.refresh),
                              label: context.tr('try_again'),
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
                          if (isLast) SizedBox(height: ScreenUtil.sh(10)),
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