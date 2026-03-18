import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/providers/storage_providers.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';
  static const _legacyKey = 'is_dark';

  @override
  ThemeMode build() {
    final storage = ref.read(localStorageServiceProvider);

    final saved = storage.getString(_key);
    switch (saved) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
    }

    final legacy = storage.getBool(_legacyKey);
    if (legacy != null) {
      return legacy ? ThemeMode.dark : ThemeMode.light;
    }

    return ThemeMode.system;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;

    final storage = ref.read(localStorageServiceProvider);
    switch (mode) {
      case ThemeMode.light:
        await storage.setString(_key, 'light');
      case ThemeMode.dark:
        await storage.setString(_key, 'dark');
      case ThemeMode.system:
        await storage.setString(_key, 'system');
    }
  }
}
