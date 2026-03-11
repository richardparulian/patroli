import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/providers/storage_providers.dart';

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

class ThemeModeController extends Notifier<ThemeMode> {
  static const _key = 'is_dark';

  @override
  ThemeMode build() {
    // final storage = ref.read(localStorageServiceProvider);
    // final isDark = storage.getBool(_key) ?? false;

    // return isDark ? ThemeMode.dark : ThemeMode.light;
    final storage = ref.read(localStorageServiceProvider);

    final saved = storage.getBool(_key);

    if (saved != null) {
      return saved ? ThemeMode.dark : ThemeMode.light;
    }

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final isDark = brightness == Brightness.dark;

    storage.setBool(_key, isDark);

    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;

    final storage = ref.read(localStorageServiceProvider);
    await storage.setBool(_key, mode == ThemeMode.dark);
  }
}