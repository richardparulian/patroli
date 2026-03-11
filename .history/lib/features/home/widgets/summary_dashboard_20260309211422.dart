import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

class SummaryDashboard extends ConsumerWidget {
  const SummaryDashboard({super.key, required this.reportsState});
  
  final ReportsState reportsState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final reportsState = ref.watch(reportsStateProvider);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ← Column untuk Laporan Tertunda
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Laporan Tertunda',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('${reportsState.countByStatus}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Total Laporan',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('${reportsState.totalReports}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Icon(Iconsax.chart_square5, color: color.onPrimaryContainer, size: 36),
      ],
    );
  }
}