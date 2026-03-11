import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gagal Memuat Data',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(reportsState.errorMessage ?? 'Terjadi kesalahan',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            Icon(Iconsax.close_circle, color: Colors.red, size: 36),
          ],
        ),
        const SizedBox(height: 16),
        // ← Retry Button
        ElevatedButton.icon(
          onPressed: () {
            ref.read(reportsStateProvider.notifier).getReports(pagination: 0);
          },
          icon: const Icon(Iconsax.refresh, size: 18),
          label: const Text('Coba Lagi'),
          style: ElevatedButton.styleFrom(
            backgroundColor: color.primary,
            foregroundColor: color.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}