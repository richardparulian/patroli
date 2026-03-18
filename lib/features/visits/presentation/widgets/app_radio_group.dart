import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/constants/visit_constants.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/ui/cards/app_card_alert.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/l10n/l10n.dart';

class AppRadioGroup<T> extends ConsumerWidget {
  final String? title;
  final IconData? icon;
  final T? value;
  final List<T> options;
  final String? errorText;
  final String notes;
  final int condition;
  final ValueChanged<T> onChanged;

  const AppRadioGroup({
    super.key,
    this.title,
    this.icon,
    required this.value,
    required this.options,
    this.errorText,
    this.notes = '',
    this.condition = 0,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(left: 16, top: 16, right: 16, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: ScreenUtil.paddingFromDesign(all: 8),
                      decoration: BoxDecoration(
                        color: color.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                      ),
                      child: Icon(icon, size: ScreenUtil.icon(18), color: color.primary),
                    ),
                    SizedBox(width: ScreenUtil.sw(10)),
                  ],
                  Text(
                    title ?? '---',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: ScreenUtil.sp(16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: ScreenUtil.sh(15)),
            if (condition > VisitConstants.available) ...[
              AppAlertCard(
                title: context.tr('information'),
                message: context.tr('empty_shop_land'),
                type: AlertType.error,
              ),
              SizedBox(height: ScreenUtil.sh(10)),
            ],
            ...options.map(
              (option) => _RadioItem(
                label: option.toString(),
                selected: option == value,
                onTap: () {
                  onChanged(option);
                },
              ),
            ),
            if (errorText != null) ...[
              SizedBox(height: ScreenUtil.sh(6)),
              Text(
                errorText ?? '---',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontSize: ScreenUtil.sp(12),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: ScreenUtil.sh(6)),
            ],
          ],
        ),
      ),
    );
  }
}

class _RadioItem extends ConsumerWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RadioItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(vertical: 10),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: ScreenUtil.sw(22),
              height: ScreenUtil.sw(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: ScreenUtil.sw(2),
                  color: selected ? color.primary : color.outline,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: ScreenUtil.sw(10),
                        height: ScreenUtil.sw(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: ScreenUtil.sw(12)),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
