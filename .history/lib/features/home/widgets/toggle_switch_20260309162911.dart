import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/providers/theme_providers.dart';

class ThemeToggleSwitch extends ConsumerWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedToggleSwitch<bool>.dual(
        current: themeMode == ThemeMode.dark,
        first: false,
        second: true,
        spacing: 0,
        animationDuration: const Duration(milliseconds: 400),
        style: const ToggleStyle(
          backgroundColor: Colors.black,
          indicatorColor: Colors.white,
          // borderWidth: 0,
          // borderRadius: BorderRadius.circular(8),
          // indicatorBorderRadius: BorderRadius.circular(6),
        ),
        onChanged: (isDark) {
          ref.read(themeModeProvider.notifier).set(
            isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
        iconBuilder: (value) {
          return Icon(value ? Iconsax.moon : Iconsax.sun_1, color: theme.colorScheme.onPrimary, size: 24);
        },
      ),
    );
  }
}