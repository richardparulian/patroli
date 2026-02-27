import 'package:flutter/material.dart';
import 'package:pos/core/constants/app_constants.dart';

enum ButtonType { primary, outlined, text }

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double fontSize;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? indicator;
  final MainAxisSize mainAxisSize;
  // final Color backgroundColor;
  // final Color foregroundColor;
  // final Color? disabledBackgroundColor;
  // final Color? disabledForegroundColor;
  // final Color borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? borderColor;
  final ButtonType type;
  final OutlinedBorder shape;
  final EdgeInsetsGeometry? padding;

  AppButton({
    super.key,
    this.onPressed,
    this.label,
    this.fontSize = 15.0,
    this.height = 45.0,
    this.borderRadius = 16.0,
    this.icon,
    this.indicator,
    this.mainAxisSize = MainAxisSize.max,
    // this.backgroundColor = AppConstants.primaryColor,
    // this.foregroundColor = Colors.white,
    // this.disabledBackgroundColor,
    // this.disabledForegroundColor,
    // this.borderColor = AppConstants.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.type = ButtonType.primary,
    OutlinedBorder? shape,
    this.padding,
  }): shape = shape ?? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
  );

  @override
  Widget build(BuildContext context) {
    // final bg = backgroundColor;
    // final fg = foregroundColor;
    // final br = borderColor;

    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final bg = backgroundColor ?? (type == ButtonType.primary ? color.primary : Colors.transparent);
    final fg = foregroundColor ?? color.onPrimary;
    final br = borderColor ?? color.primary;

    ButtonStyle style;

    switch (type) {
      case ButtonType.primary:
        style = ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: bg,
          foregroundColor: fg,
          textStyle: TextStyle(fontSize: fontSize),
          disabledBackgroundColor: disabledBackgroundColor ?? color.surfaceContainerHighest,
          disabledForegroundColor: disabledForegroundColor ?? color.onSurface.withValues(alpha: 0.5),
          fixedSize: Size(double.infinity, height),
          shape: shape,
        );
        break;

      case ButtonType.outlined:
        style = OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: br, width: 1.2),
          fixedSize: Size(double.infinity, height),
          shape: shape,
        );
        break;

      case ButtonType.text:
        style = TextButton.styleFrom(
          foregroundColor: fg,
          padding: EdgeInsets.zero,
        );
        break;
    }

    final child = Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          if (label != null) SizedBox(width: 8),
        ],
        if (indicator != null) ...[
          indicator!,
          if (label != null) SizedBox(width: 8),
        ],
        if (label != null) ...[
          Text(label ?? '---'),
        ],
      ],
    );

    return _buildButton(style, child);
  }

  Widget _buildButton(ButtonStyle style, Widget child) {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );

      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
    }
  }
}
