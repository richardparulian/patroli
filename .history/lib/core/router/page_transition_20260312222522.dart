import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageTransition({required Widget child, required GoRouterState state }) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween(
        begin: const Offset(0.1, 0),
        end: Offset.zero,
      ).animate(animation);

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: slide,
          child: child,
        ),
      );
    },
  );
}