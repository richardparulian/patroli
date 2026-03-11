import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/extensions/string_extensions.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/core/ui/animation/animated_card.dart';

class ReportCard extends ConsumerWidget {
  final ReportsEntity report;
  final VoidCallback onTap;

  const ReportCard({super.key, required this.report, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final isCompleted = report.statusValue == 0;

    return AnimatedMenuCard(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Branch Name + Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Iconsax.shop, size: 20, color: color.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(report.branch.name ?? '---',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(report.date ?? '---',
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
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Iconsax.clock, size: 16, color: color.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Text('${report.checkIn} - ${report.checkOut}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: color.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(Iconsax.user, size: 16, color: color.onSurfaceVariant),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    Text(report.createdBy.name.firstNameSecondName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Row(
              //   children: [
              //     _buildQuickStatusItem(
              //       context,
              //       icon: Iconsax.flash_circle,
              //       status: report.lightsStatus,
              //       label: 'Lampu',
              //     ),
              //     const SizedBox(width: 8),
              //     _buildQuickStatusItem(
              //       context,
              //       icon: Iconsax.gallery,
              //       status: report.bannerStatus,
              //       label: 'Banner',
              //     ),
              //     const SizedBox(width: 8),
              //     _buildQuickStatusItem(
              //       context,
              //       icon: Icons.door_front_door,
              //       status: report.rollingDoorStatus,
              //       label: 'Pintu',
              //     ),
              //   ],
              // ),
              
              // Preview Notes (jika ada)
              // if (report.notes != null && report.notes!.isNotEmpty && report.notes!.trim().isNotEmpty) ...[
              //   const SizedBox(height: 10),
              //   Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       color: color.tertiaryContainer.withValues(alpha: 0.5),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           Iconsax.note_1,
              //           size: 16,
              //           color: color.onTertiaryContainer,
              //         ),
              //         const SizedBox(width: 8),
              //         Expanded(
              //           child: Text(
              //             report.notes!,
              //             style: theme.textTheme.bodySmall?.copyWith(
              //               color: color.onTertiaryContainer,
              //             ),
              //             maxLines: 1,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ThemeData theme, bool isCompleted) {
    final color = isCompleted ? Colors.green : Colors.orange;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: color, 
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isCompleted ? Iconsax.tick_circle : Iconsax.clock, size: 14, color: color),
          const SizedBox(width: 4),
          Text(isCompleted ? 'Selesai' : 'Tertunda', 
            style: theme.textTheme.labelSmall?.copyWith(
              color: color, fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatusItem(
    BuildContext context, {
    required IconData icon,
    required String? status,
    required String label,
  }) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    final statusText = status?.toLowerCase() ?? '';
    
    Color itemColor;
    IconData statusIcon;
    
    if (statusText.contains('baik') || 
        statusText.contains('ok') || 
        statusText.contains('aman') ||
        statusText.contains('nyala') ||
        statusText.contains('terbuka')) {
      itemColor = Colors.green;
      statusIcon = Iconsax.tick_circle;
    } else if (statusText.contains('rusak') || 
               statusText.contains('tidak ok') || 
               statusText.contains('bahaya') ||
               statusText.contains('mati') ||
               statusText.contains('terkunci')) {
      itemColor = Colors.red;
      statusIcon = Iconsax.danger;
    } else {
      itemColor = color.outline;
      statusIcon = Iconsax.info_circle;
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: itemColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 18,
              color: itemColor,
            ),
            const SizedBox(height: 4),
            Icon(
              statusIcon,
              size: 12,
              color: itemColor,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}