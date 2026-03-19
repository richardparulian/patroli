import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/core/storage/cache/cache_manager.dart';
import 'package:patroli/core/utils/extensions/date_time_extensions.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/core/ui/animation/animated_card.dart';
import 'package:patroli/features/reports/presentation/providers/reports_flow_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

class ReportCard extends ConsumerStatefulWidget {
  final ReportsEntity report;
  final VoidCallback onTap;

  const ReportCard({super.key, required this.report, required this.onTap});

  @override
  ConsumerState<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<ReportCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final isCompleted = widget.report.statusValue == 2;

    final imageCheckIn = widget.report.checkInPhoto ?? '';
    final imageCheckOut = widget.report.checkOutPhoto ?? '';

    final imageUrls = [
      imageCheckIn,
      imageCheckOut,
    ].where((url) => url.isNotEmpty).toList();

    final reportId = widget.report.id ?? 0;
    final currentIndex = ref.watch(
      reportsFlowProvider.select((state) => state.carouselIndexFor(reportId)),
    );

    return AnimatedMenuCard(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.sw(16),
          vertical: ScreenUtil.sh(8),
        ),
        child: Padding(
          padding: ScreenUtil.paddingFromDesign(all: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: ScreenUtil.paddingFromDesign(all: 8),
                          decoration: BoxDecoration(
                            color: color.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil.radius(10),
                            ),
                          ),
                          child: Icon(
                            Iconsax.shop,
                            size: ScreenUtil.icon(20),
                            color: color.primary,
                          ),
                        ),
                        SizedBox(width: ScreenUtil.sw(12)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.report.branch?.name ?? '---',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.report.date?.toFullDate() ?? '---',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: color.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(theme, isCompleted),
                ],
              ),
              SizedBox(height: ScreenUtil.sh(12)),
              Container(
                padding: ScreenUtil.paddingFromDesign(all: 12),
                decoration: BoxDecoration(
                  color: color.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(ScreenUtil.radius(16)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.login,
                                size: ScreenUtil.icon(20),
                                color: color.onSurfaceVariant,
                              ),
                              SizedBox(width: ScreenUtil.sw(12)),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr('check_in_label'),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: color.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil.sh(4)),
                                  Text(
                                    widget.report.checkIn?.toTimeWithZone() ??
                                        '---',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: color.onSurfaceVariant,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil.sh(10)),
                          Row(
                            children: [
                              Icon(
                                Iconsax.logout,
                                size: ScreenUtil.icon(20),
                                color: color.onSurfaceVariant,
                              ),
                              SizedBox(width: ScreenUtil.sw(10)),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr('check_out_label'),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: color.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil.sh(4)),
                                  Text(
                                    widget.report.checkOut?.toTimeWithZone() ??
                                        '---',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: color.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 0.2,
                      height: size.width > 600
                          ? size.width * 0.1
                          : size.width * 0.2,
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        borderRadius: BorderRadius.circular(
                          ScreenUtil.radius(10),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil.sw(12)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: size.width > 600
                              ? size.width * 0.1
                              : size.width * 0.15,
                          height: size.width > 600
                              ? size.width * 0.1
                              : size.width * 0.15,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: size.width > 600
                                  ? size.width * 0.1
                                  : size.width * 0.15,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              onPageChanged: (carouselIndex, reason) {
                                ref
                                    .read(reportsFlowProvider.notifier)
                                    .setCarouselIndex(reportId, carouselIndex);
                              },
                            ),
                            items: imageUrls.isNotEmpty
                                ? imageUrls.map((url) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            ScreenUtil.radius(10),
                                          ),
                                          child: GestureDetector(
                                            onTap: null,
                                            child: CachedNetworkImage(
                                              cacheManager:
                                                  AppCacheManager.instance,
                                              imageUrl: url,
                                              fit: BoxFit.cover,
                                              width: size.width > 600
                                                  ? size.width * 0.1
                                                  : size.width * 0.2,
                                              height: size.width > 600
                                                  ? size.width * 0.1
                                                  : size.width * 0.2,
                                              placeholder: (_, _) => Image.asset(
                                                'assets/images/placeholder/placeholder.webp',
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (_, _, _) => Image.asset(
                                                'assets/images/placeholder/error_image.webp',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList()
                                : [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/error_image.png',
                                        fit: BoxFit.cover,
                                        width: size.width > 600
                                            ? size.width * 0.1
                                            : size.width * 0.2,
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil.sh(6)),
                        if (imageUrls.length > 1) ...[
                          AnimatedSmoothIndicator(
                            activeIndex: currentIndex,
                            count: imageUrls.length,
                            effect: WormEffect(
                              dotHeight: ScreenUtil.sh(6),
                              dotWidth: ScreenUtil.sw(6),
                              activeDotColor: color.primary,
                              dotColor: Colors.grey,
                            ),
                          ),
                        ],
                      ],
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

  Widget _buildStatusBadge(ThemeData theme, bool isCompleted) {
    final color = isCompleted ? Colors.green : Colors.orange;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.sw(10),
        vertical: ScreenUtil.sh(5),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
        border: Border.all(width: 1, color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Iconsax.tick_circle : Iconsax.clock,
            size: ScreenUtil.icon(14),
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isCompleted ? context.tr('completed') : context.tr('pending'),
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
