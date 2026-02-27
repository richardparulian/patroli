import 'package:flutter/material.dart';

enum ButtonType { primary, outlined, text }

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double fontSize;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? indicator;
  final MainAxisSize mainAxisSize;
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
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.type = ButtonType.primary,
    OutlinedBorder? shape,
    this.padding,
  }) : shape = shape ?? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
  );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() {
        _isPressed = true;
      });
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final bg = widget.backgroundColor ?? (widget.type == ButtonType.primary ? color.primary : Colors.transparent);
    final br = widget.borderColor ?? color.primary;

    ButtonStyle style;

    switch (widget.type) {
      case ButtonType.primary:
        style = ElevatedButton.styleFrom(
          padding: widget.padding,
          backgroundColor: bg,
          foregroundColor: color.onPrimary,
          textStyle: TextStyle(fontSize: widget.fontSize),
          disabledBackgroundColor: widget.disabledBackgroundColor ?? color.surfaceContainerHighest,
          disabledForegroundColor: widget.disabledForegroundColor ?? color.onSurface.withValues(alpha: 0.5),
          fixedSize: Size(double.infinity, widget.height),
          shape: widget.shape,
          elevation: _isPressed ? 2 : 4,
        );
        break;

      case ButtonType.outlined:
        style = OutlinedButton.styleFrom(
          foregroundColor: color.onSurface,
          textStyle: TextStyle(fontSize: widget.fontSize),
          side: BorderSide(color: br, width: 1.2),
          fixedSize: Size(double.infinity, widget.height),
          shape: widget.shape,
          elevation: _isPressed ? 0 : 2,
        );
        break;

      case ButtonType.text:
        style = TextButton.styleFrom(
          foregroundColor: color.primary,
          padding: EdgeInsets.zero,
        );
        break;
    }

    final child = Row(
      mainAxisSize: widget.mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          widget.icon!,
          if (widget.label != null) const SizedBox(width: 8),
        ],
        if (widget.indicator != null) ...[
          widget.indicator!,
          if (widget.label != null) const SizedBox(width: 8),
        ],
        if (widget.label != null) ...[
          Text(widget.label ?? '---'),
        ],
      ],
    );

    final buttonWidget = _buildButton(style, child);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: buttonWidget,
          ),
        );
      },
      child: buttonWidget,
    );
  }

  Widget _buildButton(ButtonStyle style, Widget child) {
    switch (widget.type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: widget.onPressed,
          style: style,
          child: child,
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: widget.onPressed,
          style: style,
          child: child,
        );

      case ButtonType.text:
        return TextButton(
          onPressed: widget.onPressed,
          style: style,
          child: child,
        );
    }
  }
}
