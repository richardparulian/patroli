import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/enums/alert_type.dart';

class AppAlertCard extends StatelessWidget {
  final String title;
  final String message;
  final int condition;
  final IconData? customIcon;
  final Color? customColor;
  final AlertType type;
  final VoidCallback? onClose;

  const AppAlertCard({
    super.key,
    required this.title,
    required this.message,
    this.condition = 0,
    this.customIcon,
    this.customColor,
    this.type = AlertType.info,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color color;
    IconData icon;

    switch (type) {
      case AlertType.error:
        color = colorScheme.error;
        icon = Iconsax.info_circle;
        break;
      case AlertType.warning:
        color = Colors.orange;
        icon = Iconsax.danger;
        break;
      case AlertType.success:
        color = Colors.green;
        icon = Iconsax.tick_circle;
        break;
      case AlertType.info:
        color = colorScheme.primary;
        icon = Iconsax.info_circle;
        break;
      case AlertType.custom:
        color = customColor ?? colorScheme.primary;
        icon = customIcon ?? Iconsax.info_circle;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: color.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('$title - ${condition > AppConstants.store ? ' Lahan Kosong' : ''}',
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (condition > AppConstants.store) ...[
                          Text('Lahan Kosong',
                            style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.75),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(message,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),

              if (onClose != null) ...[
                const SizedBox(width: 12),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close, size: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}