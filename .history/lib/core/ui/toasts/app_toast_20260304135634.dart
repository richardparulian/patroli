import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Global service untuk menampilkan toast/snackbar dengan style konsisten
/// Mendukung posisi: top (floating di atas) dan bottom (fixed di bawah)
enum SnackBarPosition {
  top,
  bottom,
}

class AppToast {
  /// Tampilkan pesan error dengan modern style
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismiss,
    SnackBarPosition position = SnackBarPosition.top,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: null,
      icon: Iconsax.close_circle,
      iconColor: null,
      duration: duration,
      position: position,
      onDismiss: onDismiss,
    );
  }

  /// Tampilkan pesan success dengan modern style
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: null,
      icon: Iconsax.tick_circle,
      iconColor: null,
      duration: duration,
      position: position,
      onDismiss: onDismiss,
    );
  }

  /// Tampilkan pesan info dengan modern style
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: null,
      icon: Iconsax.info_circle,
      iconColor: null,
      duration: duration,
      position: position,
      onDismiss: onDismiss,
    );
  }

  /// Tampilkan pesan warning dengan modern style
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismiss,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: null,
      icon: Iconsax.warning_2,
      iconColor: const Color(0xFFFFA500),
      duration: duration,
      position: position,
      onDismiss: onDismiss,
    );
  }

  /// Tampilkan pesan dengan custom style (subtitle, modern)
  static void showCustom({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    required IconData icon,
    Color? iconColor,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      duration: duration,
      position: position,
      onDismiss: onDismiss,
    );
  }

  /// Method internal untuk menampilkan snackbar
  static void _showSnackBar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    required IconData icon,
    Color? iconColor,
    required Duration duration,
    required SnackBarPosition position,
    VoidCallback? onDismiss,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.error;
    final iconClr = iconColor ?? colorScheme.onPrimary;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        behavior: position == SnackBarPosition.top
            ? SnackBarBehavior.floating
            : SnackBarBehavior.fixed,
        margin: position == SnackBarPosition.top
            ? const EdgeInsets.all(16)
            : const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
              ),
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
              child: Icon(
                icon,
                color: iconClr,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
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
        if (context.mounted) {
          onDismiss!();
        }
      });
    }
  }

  /// Hide current snackbar
  static void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clear semua snackbar
  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
