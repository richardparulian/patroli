import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:patroli/core/utils/screen_util.dart';

class ReportCardShimmer extends ConsumerWidget {
  const ReportCardShimmer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.sw(16),
        vertical: ScreenUtil.sh(8),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
      ),
      child: Shimmer.fromColors(
        baseColor: color.surfaceContainerHighest,
        highlightColor: color.surface,
        child: Padding(
          padding: ScreenUtil.paddingFromDesign(all: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: ScreenUtil.sw(36),
                    height: ScreenUtil.sw(36),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil.sw(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: ScreenUtil.sh(14),
                          width: ScreenUtil.sw(100),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                          ),
                        ),
                        SizedBox(height: ScreenUtil.sh(6)),
                        Container(
                          height: ScreenUtil.sh(12),
                          width: ScreenUtil.sw(140),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtil.sw(10)),
                  Container(
                    width: ScreenUtil.sw(70),
                    height: ScreenUtil.sh(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil.sh(12)),
              Container(
                padding: ScreenUtil.paddingFromDesign(all: 10),
                decoration: BoxDecoration(
                  color: color.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: ScreenUtil.sw(25),
                                height: ScreenUtil.sw(25),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: ScreenUtil.sw(10)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: ScreenUtil.sh(12),
                                    width: ScreenUtil.sw(80),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil.sh(8)),
                                  Container(
                                    height: ScreenUtil.sh(12),
                                    width: ScreenUtil.sw(100),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: ScreenUtil.sw(25),
                                height: ScreenUtil.sw(25),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: ScreenUtil.sw(10)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: ScreenUtil.sh(12),
                                    width: ScreenUtil.sw(80),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil.sh(8)),
                                  Container(
                                    height: ScreenUtil.sh(12),
                                    width: ScreenUtil.sw(100),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                    SizedBox(width: ScreenUtil.sw(12)),
                    Container(
                      height: size.width > 600 ? size.width * 0.1 : size.width * 0.15,
                      width: size.width > 600 ? size.width * 0.1 : size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}