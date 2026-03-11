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

    return AnimatedToggleSwitch<bool>.dual(
      current: themeMode == ThemeMode.dark,
      first: false,    // Light mode
      second: true,   // Dark mode
      spacing: 50,
      animationDuration: const Duration(milliseconds: 400),
      style: const ToggleStyle(
        backgroundColor: Colors.black,
        indicatorColor: Colors.white,
      ),
      onChanged: (isDark) {
        ref.read(themeModeProvider.notifier).set(
          isDark ? ThemeMode.dark : ThemeMode.light,
        );
      },
      iconBuilder: (value) {
        return Icon(
          value ? Iconsax.moon : Iconsax.sun_1,
          color: Colors.white,
          size: 32,
        );
      },
      textBuilder: (value) {
        return Text(value ? 'Gelap' : 'Terang',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}