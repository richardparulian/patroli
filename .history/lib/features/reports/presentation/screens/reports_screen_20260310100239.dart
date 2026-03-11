import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';
import 'package:pos/features/reports/widgets/reports_card.dart';
import 'package:pos/features/home/widgets/shimmer_dashboard.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late final PagingController<int, ReportsEntity> _pagingController;

  Future<List<ReportsEntity>> _fetchReports(int pageKey) async {
    final notifier = ref.read(reportsStateProvider.notifier);
    
    await notifier.getReports(
      page: pageKey,
      limit: 10,
      pagination: 1,
    );
    
    // Ambil state terbaru
    final state = ref.read(reportsStateProvider);
    
    if (state.isError) {
      throw Exception(state.errorMessage ?? 'Terjadi kesalahan');
    }
    
    return state.reports;
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
        title: const Text('Daftar Laporan'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh),
            onPressed: () => _pagingController.refresh(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: CustomScrollView(
          slivers: [
            // Summary Stats
            // SliverToBoxAdapter(
            //   child: Container(
            //     margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            //     padding: const EdgeInsets.all(14),
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: [color.primary, color.primaryContainer],
            //       ),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Row(
            //       children: [
            //         _buildStatColumn(
            //           context,
            //           icon: Iconsax.clock,
            //           iconColor: Colors.orange,
            //           value: '${reportsState.countByStatus}',
            //           label: 'Tertunda',
            //         ),
            //         Container(
            //           width: 1,
            //           height: 50,
            //           color: color.onPrimary.withValues(alpha: 0.3),
            //         ),
            //         _buildStatColumn(
            //           context,
            //           icon: Iconsax.document_text_1,
            //           iconColor: Colors.white,
            //           value: '${reportsState.totalReports}',
            //           label: 'Total',
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            
            // VERSI 5.x: Menggunakan PagingListener dan PagedSliverList baru
            PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) => PagedSliverList<int, ReportsEntity>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<ReportsEntity>(
                  firstPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.all(16),
                    child: ShimmerDashboard(),
                  ),
                  newPageProgressIndicatorBuilder: (_) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => Center(
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
                  ),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.danger,
                            size: 64,
                            color: color.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Terjadi Kesalahan',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: color.error,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (reportsState.errorMessage != null)
                            Text(
                              reportsState.errorMessage!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: color.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => _pagingController.refresh(),
                            icon: const Icon(Iconsax.refresh),
                            label: const Text('Coba Lagi'),
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

  Widget _buildStatColumn(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: iconColor,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.onPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color.onPrimary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}