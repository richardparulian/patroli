import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_constants.dart';
import 'package:patroli/app/router/route_args/check_out_route_args.dart';
import 'package:patroli/app/router/route_args/image_route_args.dart';
import 'package:patroli/app/router/route_args/visit_route_args.dart';
import 'package:patroli/core/storage/cache/cache_manager.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/utils/extensions/date_time_extensions.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/extensions/extensions.dart';

class ReportsDetailScreen extends ConsumerStatefulWidget {
  final ReportsEntity reportData;
  
  const ReportsDetailScreen({super.key, required this.reportData});

  @override
  ConsumerState<ReportsDetailScreen> createState() => _ReportsDetailScreenState();
}

class _ReportsDetailScreenState extends ConsumerState<ReportsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    final isCompleted = widget.reportData.statusValue == 2;
    final report = widget.reportData;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: color.surface,
        backgroundColor: color.surface,
        title: Text(report.branch?.name ?? 'Detail Laporan'),
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(theme: theme, report: report, isCompleted: isCompleted),
            const SizedBox(height: 16),
            _buildInformationCard(theme: theme, report: report),
            const SizedBox(height: 12),
            _buildPhotosCard(context: context, report: report),
            const SizedBox(height: 20),
            if (!isCompleted) ...[
              AppIconButton(
                label: 'Lanjutan',
                icon: const Icon(Iconsax.next),
                type: IconButtonType.primary,
                minimumSize: const Size(double.infinity, 45),
                onPressed: () {
                  if (report.isEmptyReport) {
                    context.push(AppConstants.visitRoute, extra: VisitRouteArgs(report: report));
                  }

                  if (!report.isEmptyReport) {
                    context.push(AppConstants.checkOutRoute, extra: CheckOutRouteArgs(
                      reportId: report.id ?? 0,
                      branchId: report.branch?.id ?? 0,
                      branchName: report.branch?.name ?? '-',
                    ));
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard({
    required ThemeData theme,
    required ReportsEntity report,
    required bool isCompleted,
  }) {
    final color = theme.colorScheme;

    return Card(
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
                  Text(report.branch?.name ?? '---',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(report.date?.toFullDate() ?? '---',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            _buildStatusBadge(isCompleted, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCard({
    required ThemeData theme,
    required ReportsEntity report,
  }) {
    final color = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.login,
                    title: 'Masuk',
                    value: report.checkIn?.toTimeWithZone(),
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.logout,
                    title: 'Keluar',
                    value: report.checkOut?.toTimeWithZone(),
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.lamp_charge,
                    title: 'Status Lampu',
                    value: report.lightsStatus?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.image,
                    title: 'Status Banner',
                    value: report.bannerStatus?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.sidebar_right,
                    title: 'Kondisi Kanan',
                    value: report.conditionRight?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.sidebar_left,
                    title: 'Kondisi Kiri',
                    value: report.conditionLeft?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.undo,
                    title: 'Kondisi Belakang',
                    value: report.conditionBack?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.story,
                    title: 'Kondisi Sekitar',
                    value: report.conditionAround?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _infoItem(
              icon: Icons.door_front_door,
              title: 'Status Rolling Door',
              value: report.rollingDoorStatus?.trim() ?? '---',
              theme: theme,
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 0.5,
              color: color.onSurface.withValues(alpha: .2),
            ),
            const SizedBox(height: 5),
            Text('Catatan',
              style: theme.textTheme.titleMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(report.notes?.trim() ?? '---',
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotosCard({
    required BuildContext context,
    required ReportsEntity report,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (report.checkInPhoto?.trim().isNotEmpty ?? false) ...[
              _photoItem(
                context: context,
                title: 'Foto Masuk',
                url: report.checkInPhoto?.trim() ?? '',
              ),
            ],
            if (report.checkOutPhoto?.trim().isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              _photoItem(
                context: context,
                title: 'Foto Keluar',
                url: report.checkOutPhoto?.trim() ?? '',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoItem({required IconData icon, required String title, String? value, required ThemeData theme}) {
    final color = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color.primary),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(value ?? '---',
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
            debugPrint('urls: $url');
            context.push(AppConstants.imagePreviewRoute, extra: ImageRouteArgs(
              imageUrl: url, 
              title: title,
            ),
          );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              height: 220,
              imageUrl: url,
              fit: BoxFit.cover,
              width: double.infinity,
              cacheManager: AppCacheManager.instance,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(bool completed, ThemeData theme) {
    final color = completed ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10, 
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        completed ? 'Selesai' : 'Tertunda',
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}