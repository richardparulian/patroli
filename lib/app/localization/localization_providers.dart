import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/l10n/l10n.dart';

const _languageCodeKey = 'selected_language_code';

final savedLocaleProvider = Provider<Locale>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final savedLanguageCode = prefs.getString(_languageCodeKey);

  if (savedLanguageCode != null &&
      AppLocalizations.supportedLocales.any(
        (l) => l.languageCode == savedLanguageCode,
      )) {
    return Locale(savedLanguageCode);
  }

  return const Locale('id');
});

final persistentLocaleProvider =
    NotifierProvider<PersistentLocaleNotifier, Locale>(
      PersistentLocaleNotifier.new,
    );

class PersistentLocaleNotifier extends Notifier<Locale> {
  static const _languageCodeKey = 'selected_language_code';

  @override
  Locale build() {
    return ref.watch(savedLocaleProvider);
  }

  Future<void> setLocale(Locale locale) async {
    if (AppLocalizations.isSupported(locale)) {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString(_languageCodeKey, locale.languageCode);
      state = locale;
    }
  }

  Future<void> resetToSystemLocale() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_languageCodeKey);
    state = const Locale('id');
  }
}
