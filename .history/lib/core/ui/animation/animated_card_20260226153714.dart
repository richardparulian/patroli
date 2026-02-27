import 'package:flutter/material.dart';

class _AnimatedMenuCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedMenuCard({required this.child, required this.onTap});

  @override
  State<_AnimatedMenuCard> createState() => _AnimatedMenuCardState();
}

class _AnimatedMenuCardState extends State<_AnimatedMenuCard> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.97),
      onTapUp: (_) {
        setState(() => scale = 1);
        widget.onTap();
      },
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}