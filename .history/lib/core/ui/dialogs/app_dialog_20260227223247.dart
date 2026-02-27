import 'package:flutter/material.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/ui/buttons/app_button.dart';

enum DialogType {
  info,
  success,
  error,
  warning,
  confirm,
}

class AppDialog {
  AppDialog._();

  static Future<T?> _showDialog<T>({required BuildContext context, required WidgetBuilder builder, bool barrierDismissible = true, Color? barrierColor}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
      builder: builder,
    );
  }

  static Widget _buildDialogContent({required Widget title, required Widget content, required List<Widget> actions, IconData? icon, Color? iconColor, EdgeInsets? contentPadding, double? borderRadius, Color? backgroundColor}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
      ),
      backgroundColor: backgroundColor,
      titlePadding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(20, 20, 20, 20),
      title: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.blue).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(child: title),
        ],
      ),
      content: content,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            children: actions,
          ),
        ),
      ],
    );
  }

  static Future<bool?> showConfirm({required BuildContext context,
    required String title, required String message, String confirmText = 'Ya', String cancelText = 'Batal', VoidCallback? onConfirm, VoidCallback? onCancel, bool barrierDismissible = true}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _buildDialogContent(
        title: Text(title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Icons.help_outline,
        iconColor: AppConstants.primaryColor,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop(false);
              },
              label: cancelText,
              type: ButtonType.outlined,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop(true);
              },
              label: confirmText,
              type: ButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return _showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _buildDialogContent(
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Icons.info_outline,
        iconColor: Colors.blue,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText,
              type: ButtonType.primary,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return _showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _buildDialogContent(
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText,
              type: ButtonType.primary,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return _showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _buildDialogContent(
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Icons.error_outline,
        iconColor: Colors.red,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText,
              type: ButtonType.primary,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return _showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _buildDialogContent(
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Icons.warning_amber_outlined,
        iconColor: Colors.orange,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText,
              type: ButtonType.primary,
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> showCustom<T>({
    required BuildContext context,
    required Widget title,
    required Widget content,
    required List<Widget> actions,
    bool barrierDismissible = true,
    Color? barrierColor,
    EdgeInsets? contentPadding,
    double? borderRadius,
    Color? backgroundColor,
  }) {
    return _showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        backgroundColor: backgroundColor,
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24, 20, 24, 24),
        title: title,
        content: content,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: Row(
              children: actions,
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showDeleteConfirm({
    required BuildContext context,
    String? itemName,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showConfirm(
      context: context,
      title: 'Hapus ${itemName ?? 'Item'}?',
      message: 'Apakah Anda yakin ingin menghapus ${itemName ?? 'item'} ini? Tindakan ini tidak dapat dibatalkan.',
      confirmText: 'Hapus',
      cancelText: 'Batal',
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool?> showLogoutConfirm({
    required BuildContext context,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showConfirm(
      context: context,
      title: 'Keluar?',
      message: 'Apakah Anda yakin ingin keluar dari aplikasi?',
      confirmText: 'Keluar',
      cancelText: 'Batal',
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
