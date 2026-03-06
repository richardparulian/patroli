import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppToastService {
  static void showError({required BuildContext context, required String message, Duration duration = const Duration(seconds: 4), VoidCallback? onDismiss}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary,
              ),
              child: Icon(Iconsax.close_circle, color: colorScheme.error, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    if (onDismiss != null) {
      Future.delayed(duration, () {
        if (context.mounted) onDismiss.call();
      }); 
    }
  }

  static void showSuccess({required BuildContext context, required String message, Duration duration = const Duration(seconds: 3), VoidCallback? onDismiss}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary,
              ),
              child: Icon(Iconsax.tick_circle, color: colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    if (onDismiss != null) {
      Future.delayed(duration, () {
        if (context.mounted) onDismiss.call();
      }); 
    }
  }

  static void showInfo({required BuildContext context, required String message, Duration duration = const Duration(seconds: 3), VoidCallback? onDismiss}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary,
              ),
              child: Icon(Iconsax.info_circle, color: colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    if (onDismiss != null) {
      Future.delayed(duration, () {
        if (context.mounted) onDismiss.call();
      }); 
    }
  }

  static void showWarning({required BuildContext context, required String message, Duration duration = const Duration(seconds: 4), VoidCallback? onDismiss}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFFFA500),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary,
              ),
              child: Icon(Iconsax.warning_2, color: const Color(0xFFFFA500), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    if (onDismiss != null) {
      Future.delayed(duration, () {
        if (context.mounted) onDismiss.call();
      }); 
    }
  }

  static void showCustom({required BuildContext context, required String message, required Color backgroundColor, required IconData icon, required Color iconColor, Duration duration = const Duration(seconds: 3), VoidCallback? onDismiss}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message,
                style: TextStyle(
                  color: backgroundColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    if (onDismiss != null) {
      Future.delayed(duration, () { 
        if (context.mounted) onDismiss.call();
      }); 
    }
  }

  static void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
