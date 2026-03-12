import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';

class AppRadioGroup<T> extends ConsumerWidget {
  final String? title;
  final IconData? icon;
  final T? value;
  final List<T> options;
  final String? errorText;
  final String notes;
  final ValueChanged<T> onChanged;

  const AppRadioGroup({
    super.key,
    this.title,
    this.icon,
    required this.value,
    required this.options,
    this.errorText,
    this.notes = '',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, size: 18, color: color.primary),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(title ?? '---',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            if (notes.isNotEmpty) ...[
              AppAlertCard(
                title: 'Informasi',
                message: notes,
                type: AlertType.error,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 6),
              Text(errorText ?? '---',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required BuildContext context, required String? value}) {
    final theme = Theme.of(context);
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.red.withValues(alpha: .2),
        ),
      ),
      margin: EdgeInsets.zero,
      color: Colors.red.withValues(alpha: .1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withValues(alpha: .2),
              ),
              child: Icon(Iconsax.info_circle, color: Colors.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(title,
                  //   style: theme.textTheme.titleMedium?.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  Text(value ?? '---',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
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
    final colorScheme = theme.colorScheme;

    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: selected ? colorScheme.primary : colorScheme.outline,
                ),
              ),
              child: selected ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                ),
              ) : null,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}