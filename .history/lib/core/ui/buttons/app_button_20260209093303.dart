import 'package:flutter/material.dart';

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
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color borderColor;
  final ButtonType type;
  final OutlinedBorder shape;
  final EdgeInsetsGeometry? padding;

  AppButton({
    super.key,
    this.onPressed,
    this.label,
    this.fontSize = 15.0,
    this.height = 45.0,
    this.borderRadius = 50.0,
    this.icon,
    this.indicator,
    this.mainAxisSize = MainAxisSize.max,
    this.backgroundColor = primaryColor,
    this.foregroundColor = Colors.white,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor = primaryColor,
    this.type = ButtonType.primary,
    OutlinedBorder? shape,
    this.padding,
  }): shape = shape ?? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
  );

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor;
    final fg = foregroundColor;
    final br = borderColor;

    ButtonStyle style;

    switch (type) {
      case ButtonType.primary:
        style = ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          if (label != null) SizedBox(width: 5),
        ],
        if (indicator != null) ...[
          indicator!,
          if (label != null) SizedBox(width: 8),
        ],
        if (label != null) ...[
          Text(label ?? '---', 
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
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
