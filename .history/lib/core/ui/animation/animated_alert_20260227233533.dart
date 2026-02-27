import 'package:flutter/material.dart';
import 'package:pos/core/constants/app_constants.dart';

enum AlertType { error, success, warning, info }

class AnimatedAlert extends StatelessWidget {
  final String message;
  final Color? color;
  final IconData? icon;
  final AlertType? alertType;
  final VoidCallback? onDismiss;
  final bool showCloseButton;

  const AnimatedAlert({
    super.key,
    required this.message,
    this.color,
    this.icon,
    this.alertType,
    this.onDismiss,
    this.showCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    // Determine color based on alert type
    Color alertColor;
    IconData alertIcon;

    if (color != null) {
      alertColor = color!;
      alertIcon = icon ?? Icons.info_outline;
    } else if (alertType != null) {
      switch (alertType!) {
        case AlertType.error:
          alertColor = Colors.red;
          alertIcon = Icons.error_outline;
          break;
        case AlertType.success:
          alertColor = Colors.green;
          alertIcon = Icons.check_circle_outline;
          break;
        case AlertType.warning:
          alertColor = Colors.orange;
          alertIcon = Icons.warning_amber_outlined;
          break;
        case AlertType.info:
          alertColor = AppConstants.primaryColor;
          alertIcon = Icons.info_outline;
          break;
      }
    } else {
      // Default to error color for backward compatibility
      alertColor = Colors.red;
      alertIcon = icon ?? Icons.error_outline;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, -0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(message),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              alertColor,
              alertColor.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: alertColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            if (!isDark)
              BoxShadow(
                color: alertColor.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                alertIcon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (showCloseButton || onDismiss != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDismiss,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
