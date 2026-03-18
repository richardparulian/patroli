import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

class SummaryDashboard extends ConsumerWidget {
  final int totalReports;
  final int byStatus;

  const SummaryDashboard({super.key, required this.totalReports, required this.byStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            context: context,
            color: color,
            dotColor: Colors.orange,
            label: context.tr('pending_reports'),
            value: '$byStatus',
          ),
        ),
        SizedBox(width: ScreenUtil.sw(12)),
        Expanded(
          child: _buildStatItem(
            context: context,
            color: color,
            dotColor: Colors.green,
            label: context.tr('total_reports'),
            value: '$totalReports',
          ),
        ),
        SizedBox(width: ScreenUtil.sw(8)),
        Icon(
          Iconsax.chart_square5,
          color: color.onPrimaryContainer,
          size: ScreenUtil.icon(28),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required ColorScheme color,
    required Color dotColor,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: ScreenUtil.sw(8),
              height: ScreenUtil.sw(8),
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: ScreenUtil.sw(8)),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: ScreenUtil.sp(11),
                  color: color.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil.sh(6)),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}