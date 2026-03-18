import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/app/router/route_args/check_out_route_args.dart';
import 'package:patroli/app/router/route_args/image_route_args.dart';
import 'package:patroli/app/router/route_args/visit_route_args.dart';
import 'package:patroli/core/storage/cache/cache_manager.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/utils/extensions/date_time_extensions.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/extensions/extensions.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

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
        title: Text(report.branch?.name ?? context.tr('report_detail')),
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: ScreenUtil.sp(18),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        padding: ScreenUtil.paddingFromDesign(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(theme: theme, report: report, isCompleted: isCompleted),
            SizedBox(height: ScreenUtil.sh(16)),
            _buildInformationCard(theme: theme, report: report),
            SizedBox(height: ScreenUtil.sh(12)),
            _buildPhotosCard(context: context, report: report),
            SizedBox(height: ScreenUtil.sh(20)),
            if (!isCompleted) ...[
              AppIconButton(
                label: context.tr('continue'),
                icon: const Icon(Iconsax.next),
                type: IconButtonType.primary,
                minimumSize: Size(double.infinity, ScreenUtil.sh(45)),
                onPressed: () {
                  if (report.isEmptyReport) {
                    context.push(AppRoutes.visit, extra: VisitRouteArgs(report: report));
                  }

                  if (!report.isEmptyReport) {
                    context.push(AppRoutes.checkOut, extra: CheckOutRouteArgs(
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
        borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(all: 16),
        child: Row(
          children: [
            Container(
              padding: ScreenUtil.paddingFromDesign(all: 10),
              decoration: BoxDecoration(
                color: color.primary.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
              ),
              child: Icon(Iconsax.shop, color: color.primary),
            ),
            SizedBox(width: ScreenUtil.sw(12)),
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
        borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(all: 16),
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
                    title: context.tr('check_in_label'),
                    value: report.checkIn?.toTimeWithZone(),
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.logout,
                    title: context.tr('check_out_label'),
                    value: report.checkOut?.toTimeWithZone(),
                    theme: theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.sh(15)),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.lamp_charge,
                    title: context.tr('lights_status'),
                    value: report.lightsStatus?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.image,
                    title: context.tr('banner_status'),
                    value: report.bannerStatus?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.sh(15)),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.sidebar_right,
                    title: context.tr('right_condition'),
                    value: report.conditionRight?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.sidebar_left,
                    title: context.tr('left_condition'),
                    value: report.conditionLeft?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.sh(15)),
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.undo,
                    title: context.tr('back_condition'),
                    value: report.conditionBack?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Iconsax.story,
                    title: context.tr('surrounding_condition'),
                    value: report.conditionAround?.trim() ?? '---',
                    theme: theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil.sh(15)),
            _infoItem(
              icon: Icons.door_front_door,
              title: context.tr('rolling_door_status'),
              value: report.rollingDoorStatus?.trim() ?? '---',
              theme: theme,
            ),
            SizedBox(height: ScreenUtil.sh(10)),
            Divider(
              thickness: 0.5,
              color: color.onSurface.withValues(alpha: .2),
            ),
            SizedBox(height: ScreenUtil.sh(5)),
            Text(context.tr('notes'),
              style: theme.textTheme.titleMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ScreenUtil.sh(8)),
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
        borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(all: 16),
        child: Column(
          children: [
            if (report.checkInPhoto?.trim().isNotEmpty ?? false) ...[
              _photoItem(
                context: context,
                title: context.tr('check_in_photo'),
                url: report.checkInPhoto?.trim() ?? '',
              ),
            ],
            if (report.checkOutPhoto?.trim().isNotEmpty ?? false) ...[
              SizedBox(height: ScreenUtil.sh(16)),
              _photoItem(
                context: context,
                title: context.tr('check_out_photo'),
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
          padding: ScreenUtil.paddingFromDesign(all: 10),
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(ScreenUtil.radius(12)),
          ),
          child: Icon(icon, color: color.primary),
        ),
        SizedBox(width: ScreenUtil.sw(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: ScreenUtil.sh(4)),
              Text(
                value ?? '---',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color.onSurfaceVariant,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
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
        SizedBox(height: ScreenUtil.sh(6)),
        GestureDetector(
          onTap: () {
            debugPrint('urls: $url');
            context.push(AppRoutes.imagePreview, extra: ImageRouteArgs(
              imageUrl: url, 
              title: title,
            ),
          );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
            child: CachedNetworkImage(
              height: ScreenUtil.sh(220),
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
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.sw(10),
        vertical: ScreenUtil.sh(6),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
        border: Border.all(color: color),
      ),
      child: Text(
        completed ? context.tr('completed') : context.tr('pending'),
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}