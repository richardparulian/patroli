import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/theme/theme_providers.dart';

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
      spacing: -5,
      height: 30,
      borderWidth: 1,
      padding: EdgeInsets.all(1),
      style: ToggleStyle(
        backgroundColor: color.onSurface,
        borderColor: color.onSurface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(50),
        indicatorColor: color.surface,
      ),
      indicatorSize: const Size(28, 28),
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (isDark) {
        ref.read(themeModeProvider.notifier).set(
          isDark ? ThemeMode.dark : ThemeMode.light,
        );
      },
      iconBuilder: (value) {
        return Icon(value ? Iconsax.moon : Iconsax.sun_1, color: theme.colorScheme.primary, size: 15);
      },
    );
  }
}