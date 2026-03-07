import 'package:flutter/material.dart';

enum IconButtonType { primary, outlined, text }

class AppIconButton extends StatefulWidget {
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
  final IconButtonType type;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;

  AppIconButton({
    super.key,
    this.onPressed,
    this.label,
    this.fontSize = 15.0,
    this.height = 45.0,
    this.borderRadius = 25.0,
    this.icon,
    this.indicator,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.type = IconButtonType.primary,
    OutlinedBorder? shape,
    this.padding,
  }) : shape = shape ?? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
  );

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> with SingleTickerProviderStateMixin {
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

    final bg = widget.backgroundColor ?? (widget.type == IconButtonType.primary ? color.primary : Colors.transparent);
    final br = widget.borderColor ?? color.primary;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: _buildButton(color, bg, br),
          ),
        );
      },
    );
  }

  Widget _buildButton(ColorScheme color, Color bg, Color br) {
    switch (widget.type) {
      case IconButtonType.primary:
        return ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon ?? const SizedBox.shrink(),
          label: widget.label != null ? Text(
            widget.label!,
            style: TextStyle(fontSize: widget.fontSize),
          ) : const SizedBox.shrink(),
          style: ElevatedButton.styleFrom(
            padding: widget.padding,
            backgroundColor: bg,
            foregroundColor: color.onPrimary,
            textStyle: TextStyle(fontSize: widget.fontSize),
            disabledBackgroundColor: widget.disabledBackgroundColor ?? color.surfaceContainerHighest,
            disabledForegroundColor: widget.disabledForegroundColor ?? color.onSurface.withValues(alpha: 0.5),
            fixedSize: Size(double.infinity, widget.height),
            shape: widget.shape,
            elevation: _isPressed ? 2 : 4,
          ),
        );

      case IconButtonType.outlined:
        return OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon ?? const SizedBox.shrink(),
          label: widget.label != null ? Text(widget.label!,
            style: TextStyle(fontSize: widget.fontSize),
          ) : const SizedBox.shrink(),
          style: OutlinedButton.styleFrom(
            padding: widget.padding,
            foregroundColor: color.onSurface,
            textStyle: TextStyle(fontSize: widget.fontSize),
            side: BorderSide(color: br, width: 1.2),
            fixedSize: Size(double.infinity, widget.height),
            shape: widget.shape,
            elevation: _isPressed ? 0 : 2,
          ),
        );

      case IconButtonType.text:
        return TextButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon ?? const SizedBox.shrink(),
          label: widget.label != null ? Text(
            widget.label!,
            style: TextStyle(fontSize: widget.fontSize),
          ) : const SizedBox.shrink(),
          style: TextButton.styleFrom(
            foregroundColor: color.primary,
            padding: widget.padding,
          ),
        );
    }
  }
}