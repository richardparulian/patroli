import 'package:flutter/material.dart';

class AnimatedMenuCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedMenuCard({super.key, required this.child, required this.onTap});

  @override
  State<AnimatedMenuCard> createState() => AnimatedMenuCardState();
}

class AnimatedMenuCardState extends State<AnimatedMenuCard> {
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