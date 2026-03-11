import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

class ErrorDashboard extends ConsumerWidget {
  const ErrorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final reportsState = ref.watch(reportsStateProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.error.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.info_circle5, size: 24, color: color.error),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gagal Memuat Data',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: color.surface,
                  ),
                ),
                Text(reportsState.errorMessage ?? 'Terjadi kesalahan',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color.surface,
                  ),
                ),
              ],
            ),
            AppIconButton(
              height: 36,
              label: 'Coba Lagi',
              type: IconButtonType.outlined,
              icon: const Icon(Iconsax.refresh, size: 18),
              onPressed: () {
                ref.read(reportsStateProvider.notifier).getReports(pagination: 0);
              },
              borderColor: color.error,
              foregroundColor: color.onSurface,
              backgroundColor: color.error,
            ),
          ],
        ),
      ],
    );
  }
}