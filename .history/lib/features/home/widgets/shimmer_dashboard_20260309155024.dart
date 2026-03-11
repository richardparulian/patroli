import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashboard extends ConsumerWidget {
  const ShimmerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Shimmer.fromColors(
      baseColor: color.primaryContainer.withValues(alpha: 0.3),
      highlightColor: color.primaryContainer.withValues(alpha: 0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildColumnShimmer(context)),
          const SizedBox(width: 20),
          Expanded(child: _buildColumnShimmer(context)),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnShimmer(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.onPrimaryContainer.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 120,
              height: 14,
              decoration: BoxDecoration(
                color: color.onPrimaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: 22,
          decoration: BoxDecoration(
            color: color.onPrimaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}