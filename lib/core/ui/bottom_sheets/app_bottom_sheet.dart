import 'dart:ui';
import 'package:flutter/material.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
    double? elevation,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      elevation: elevation,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 25),
        ),
      ),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius ?? 25),
            ),
          ),
          child: builder(context),
        ),
      ),
    );
  }

  static Future<T?> showWithKeyboard<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
    double? elevation,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      elevation: elevation,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 25),
        ),
      ),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius ?? 25),
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: builder(context),
          ),
        ),
      ),
    );
  }

  static Widget buildHeader({required BuildContext context, required String title, VoidCallback? onClose, Widget? trailing, bool isCloseButton = true}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (trailing != null) ...[ trailing, const SizedBox(width: 8) ],
        const SizedBox(width: 8),
        IconButton(
          onPressed: onClose ?? () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
