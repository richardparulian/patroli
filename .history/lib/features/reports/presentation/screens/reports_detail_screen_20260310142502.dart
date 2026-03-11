import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/storage/cache/cache_manager.dart';
import 'package:pos/core/utils/extensions/date_time_extensions.dart';

import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

class ReportsDetailScreen extends ConsumerWidget {

  const ReportsDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    final report = ref.watch(reportsStateProvider.select((state) => state.reports.first));
    
    final isCompleted = report.statusValue == 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(report.branch.name ?? "Detail Laporan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.primary.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Iconsax.shop, color: color.primary),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report.branch.name ?? "---",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            report.date?.toFullDate() ?? "---",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    _buildStatusBadge(isCompleted, theme)

                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// CHECK IN OUT
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [

                    Expanded(
                      child: _timeItem(
                        icon: Iconsax.login,
                        title: "Masuk",
                        time: report.checkIn?.toTimeWithZone(),
                        theme: theme,
                      ),
                    ),

                    Expanded(
                      child: _timeItem(
                        icon: Iconsax.logout,
                        title: "Keluar",
                        time: report.checkOut?.toTimeWithZone(),
                        theme: theme,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PHOTO
            // Text('Foto Patroli',
            //   style: theme.textTheme.titleMedium?.copyWith(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 12),
            if (report.checkInPhoto?.trim().isNotEmpty ?? false)
              _photoItem(
                context: context,
                title: 'Foto Masuk',
                url: report.checkInPhoto?.trim() ?? '',
              ),

            if (report.checkOutPhoto?.trim().isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              _photoItem(
                context: context,
                title: 'Foto Keluar',
                url: report.checkOutPhoto?.trim() ?? '',
              ),
            ],
            const SizedBox(height: 20),
            if (report.notes?.trim().isNotEmpty ?? false) ...[
              Text('Catatan',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(report.notes?.trim() ?? '---',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _timeItem({required IconData icon, required String title, String? time, required ThemeData theme}) {
    final color = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: color.primary),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Masuk',
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(time ?? '---',
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _photoItem({required BuildContext context, required String title, required String url}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) {},
            //   ),
            // );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              cacheManager: AppCacheManager.instance,
              imageUrl: url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(bool completed, ThemeData theme) {

    final color = completed ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        completed ? "Selesai" : "Tertunda",
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}