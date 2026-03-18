import 'package:flutter/material.dart';
import 'package:patroli/features/language_switcher/application/services/language_switcher_service.dart';
import 'package:patroli/features/language_switcher/domain/entities/language_switcher_entity.dart';
import 'package:patroli/app/localization/localization_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_switcher_provider.g.dart';

@riverpod
class LanguageSwitcher extends _$LanguageSwitcher {
  @override
  Future<List<LanguageSwitcherEntity>> build() async {
    final currentLocale = ref.watch(persistentLocaleProvider);
    final service = ref.read(languageSwitcherServiceProvider);
    return service.getLanguages(currentLocale);
  }

  Future<void> selectLanguage(Locale locale) async {
    state = const AsyncLoading();
    await ref.read(languageSwitcherServiceProvider).selectLanguage(locale.languageCode);
    final currentLocale = ref.read(persistentLocaleProvider);
    final languages = ref.read(languageSwitcherServiceProvider).getLanguages(currentLocale);
    state = AsyncData(languages);
  }
}
