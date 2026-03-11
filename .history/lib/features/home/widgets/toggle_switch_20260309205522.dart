import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/providers/theme_providers.dart';

class ThemeToggleSwitch extends ConsumerWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return AnimatedToggleSwitch<bool>.dual(
      current: themeMode == ThemeMode.dark,
      first: false,     // Light mode
      second: true,    // Dark mode
      spacing: 0,     // ← Hapus spacing
      height: 30,
      style: ToggleStyle(
        backgroundColor: color.surface,
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        indicatorColor: color.onSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      indicatorSize: const Size(30, 30),
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (isDark) {
        ref.read(themeModeProvider.notifier).set(
          isDark ? ThemeMode.dark : ThemeMode.light,
        );
      },
      iconBuilder: (value) {
        return Icon(value ? Iconsax.moon : Iconsax.sun_1, color: theme.colorScheme.primary, size: 20);
      },
    );
  }
}