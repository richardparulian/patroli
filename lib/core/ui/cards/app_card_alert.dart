import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/utils/screen_util.dart';

class AppAlertCard extends StatelessWidget {
  final String title;
  final String message;
  final int? condition;
  final IconData? customIcon;
  final Color? customColor;
  final AlertType type;
  final VoidCallback? onClose;

  const AppAlertCard({
    super.key,
    required this.title,
    required this.message,
    this.condition,
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
          borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
        ),
        color: color.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
            ),
          ),
          padding: ScreenUtil.paddingFromDesign(all: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: ScreenUtil.paddingFromDesign(all: 12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(ScreenUtil.radius(10)),
                ),
                child: Icon(icon, color: color, size: ScreenUtil.icon(25)), 
              ),
              SizedBox(width: ScreenUtil.sw(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: ScreenUtil.sh(2)),
                    Text(message,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),

              if (onClose != null) ...[
                SizedBox(width: ScreenUtil.sw(12)),
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