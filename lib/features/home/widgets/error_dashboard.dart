import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

class ErrorDashboard extends ConsumerWidget {
  final String errorMessage;

  const ErrorDashboard({super.key, required this.errorMessage});

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: ScreenUtil.paddingFromDesign(all: 10),
              decoration: BoxDecoration(
                color: color.error.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.info_circle5, size: ScreenUtil.icon(24), color: color.error),
            ),
            SizedBox(width: ScreenUtil.sw(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('data_load_failed'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: color.onSurface,
                    ),
                  ),
                  Text(errorMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: color.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            AppIconButton(
              height: 30,
              label: context.tr('try_again'),
              fontSize: 12,
              borderColor: color.onSurface,
              foregroundColor: color.surface,
              backgroundColor: color.onSurface,
              padding: EdgeInsets.fromLTRB(ScreenUtil.sw(10), ScreenUtil.sh(5), ScreenUtil.sw(12), ScreenUtil.sh(5)),
              icon: Icon(Iconsax.refresh, size: ScreenUtil.icon(15)),
              onPressed: () {
                ref.read(countReportsProvider.notifier).fetchCount();
              },
            ),
          ],
        ),
      ],
    );
  }
}