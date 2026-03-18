import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/core/ui/buttons/app_button.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

enum DialogType {
  info,
  success,
  error,
  warning,
  confirm,
}

class AppDialog {
  AppDialog._();

  static Future<T?> _showDialog<T>({required BuildContext context, required WidgetBuilder builder, bool barrierDismissible = true, Color? barrierColor, bool enableBlur = false, double blurSigma = 5}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: builder(context),
      ),
    );
  }

  static Widget _buildDialogContent({required Widget title, required Widget content, required List<Widget> actions, IconData? icon, Color? iconColor, EdgeInsets? contentPadding, double? borderRadius, Color? backgroundColor}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? ScreenUtil.radius(20)),
      ),
      backgroundColor: backgroundColor,
      titlePadding: EdgeInsets.fromLTRB(ScreenUtil.sw(15), ScreenUtil.sh(10), ScreenUtil.sw(15), 0),
      actionsPadding: EdgeInsets.zero,
      contentPadding: contentPadding ?? EdgeInsets.fromLTRB(ScreenUtil.sw(20), ScreenUtil.sh(20), ScreenUtil.sw(20), ScreenUtil.sh(20)),
      title: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: ScreenUtil.paddingFromDesign(all: 8),
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.blue).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: ScreenUtil.icon(24)),
            ),
            SizedBox(width: ScreenUtil.sw(10)),
          ],
          Expanded(child: title),
        ],
      ),
      content: content,
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenUtil.sw(16), 0, ScreenUtil.sw(20), ScreenUtil.sh(16)),
          child: Row(
            children: actions,
          ),
        ),
      ],
    );
  }

  static Future<bool?> showConfirm({required BuildContext context, required String title, required String message, String? confirmText, String? cancelText, VoidCallback? onConfirm, VoidCallback? onCancel, bool barrierDismissible = true}) {
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
        icon: CupertinoIcons.question_circle,
        iconColor: colorScheme.primary,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop(true);
              },
              label: cancelText ?? context.tr('cancel'),
              type: ButtonType.outlined,
            ),
          ),
          SizedBox(width: ScreenUtil.sw(12)),
          Expanded(
            child: AppButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop(true);
              },
              label: confirmText ?? context.tr('yes'),
              type: ButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showInfo({required BuildContext context, required String title, required String message, String? buttonText, VoidCallback? onButtonPressed, bool barrierDismissible = true}) {
    final theme = Theme.of(context);

    return _showDialog<void>(
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
              label: buttonText ?? context.tr('ok'),
              type: ButtonType.primary,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccess({required BuildContext context, required String title, required String message, String? buttonText, VoidCallback? onButtonPressed, bool barrierDismissible = true}) {
    final theme = Theme.of(context);

    return _showDialog<void>(
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
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Iconsax.tick_circle,
        iconColor: Colors.green,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText ?? context.tr('ok'),
              type: ButtonType.primary,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showError({required BuildContext context, required String title, required String message, String? buttonText, VoidCallback? onButtonPressed, bool barrierDismissible = true}) {
    final theme = Theme.of(context);

    return _showDialog<void>(
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
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Iconsax.info_circle,
        iconColor: Colors.red,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText ?? context.tr('ok'),
              type: ButtonType.primary,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showWarning({required BuildContext context, required String title, required String message, String? buttonText, VoidCallback? onButtonPressed, bool barrierDismissible = true}) {
    final theme = Theme.of(context);

    return _showDialog<void>(
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
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        icon: Iconsax.danger,
        iconColor: Colors.orange,
        actions: [
          Expanded(
            child: AppButton(
              onPressed: () {
                onButtonPressed?.call();
                Navigator.of(context).pop();
              },
              label: buttonText ?? context.tr('ok'),
              type: ButtonType.primary,
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> showCustom<T>({required BuildContext context, required Widget title, required Widget content, required List<Widget> actions, bool barrierDismissible = true, Color? barrierColor, EdgeInsets? contentPadding, double? borderRadius, Color? backgroundColor}) {
    return _showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? ScreenUtil.radius(20)),
        ),
        backgroundColor: backgroundColor,
        contentPadding: contentPadding ?? EdgeInsets.fromLTRB(ScreenUtil.sw(24), ScreenUtil.sh(20), ScreenUtil.sw(24), ScreenUtil.sh(24)),
        title: title,
        content: content,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenUtil.sw(24), 0, ScreenUtil.sw(24), ScreenUtil.sh(20)),
            child: Row(
              children: actions,
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showDeleteConfirm({required BuildContext context,
    required String itemName, VoidCallback? onConfirm, VoidCallback? onCancel}) {
    return showConfirm(
      context: context,
      title: context.trParams('delete_item_title', {'itemName': itemName}),
      message: context.trParams('delete_item_message', {'itemName': itemName}),
      confirmText: context.tr('yes'),
      cancelText: context.tr('cancel'),
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool?> showLogoutConfirm({required BuildContext context, VoidCallback? onConfirm, VoidCallback? onCancel}) {
    return showConfirm(
      context: context,
      title: context.tr('logout_confirmation_title'),
      message: context.tr('logout_confirmation_message'),
      confirmText: context.tr('yes'),
      cancelText: context.tr('cancel'),
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
