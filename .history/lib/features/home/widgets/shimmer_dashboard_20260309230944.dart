import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashboard extends ConsumerWidget {
  const ShimmerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: color.onPrimaryContainer.withValues(alpha: 0.2),
      highlightColor: color.onPrimaryContainer.withValues(alpha: 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _column(context),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _column(context),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.onPrimaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _column(BuildContext context) {
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
                color: color.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 110,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color.onPrimaryContainer.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          width: 60,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color.onPrimaryContainer.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}