import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/enums/alert_type.dart';

class AppAlertCard extends StatelessWidget {
  final String title;
  final String message;
  final AlertType type;
  final VoidCallback? onClose;

  const AppAlertCard({
    super.key,
    required this.title,
    required this.message,
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
        icon = Iconsax.info_circle5;
        break;
      case AlertType.warning:
        color = Colors.orange;
        icon = Iconsax.warning_2;
        break;
      case AlertType.success:
        color = Colors.green;
        icon = Iconsax.tick_circle;
        break;
      case AlertType.info:
        color = colorScheme.primary;
        icon = Iconsax.info_circle;
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
        color: color.withValues(alpha: 0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withValues(alpha: 0.9),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: textTheme.titleSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(message,
                      style: textTheme.bodySmall?.copyWith(
                        color: color.withValues(alpha: 0.75),
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