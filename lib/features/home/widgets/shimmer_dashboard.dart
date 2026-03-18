import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:patroli/core/utils/screen_util.dart';

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
          SizedBox(width: ScreenUtil.sw(20)),
          Expanded(
            child: _column(context),
          ),
          Container(
            width: ScreenUtil.sw(36),
            height: ScreenUtil.sw(36),
            decoration: BoxDecoration(
              color: color.onPrimaryContainer,
              borderRadius: BorderRadius.circular(ScreenUtil.radius(8)),
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
              width: ScreenUtil.sw(8),
              height: ScreenUtil.sw(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.onPrimaryContainer,
              ),
            ),
            SizedBox(width: ScreenUtil.sw(8)),
            Container(
              width: ScreenUtil.sw(110),
              height: ScreenUtil.sh(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil.radius(5)),
                color: color.onPrimaryContainer,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil.sh(15)),
        Container(
          width: ScreenUtil.sw(60),
          height: ScreenUtil.sh(34),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil.radius(5)),
            color: color.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}