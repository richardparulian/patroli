import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/features/reports/presentation/providers/reports_count_provider.dart';

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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.error.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.info_circle5, size: 24, color: color.error),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gagal Memuat Data',
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
              label: 'Coba Lagi',
              fontSize: 12,
              borderColor: color.onSurface,
              foregroundColor: color.surface,
              backgroundColor: color.onSurface,
              padding: const EdgeInsets.fromLTRB(10, 5, 12, 5),
              icon: const Icon(Iconsax.refresh, size: 15),
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