import 'package:flutter/material.dart';
import 'package:patroli/app/localization/localization_providers.dart';
import 'package:patroli/features/language_switcher/domain/entities/language_switcher_entity.dart';
import 'package:patroli/l10n/app_localizations_delegate.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_switcher_service.g.dart';

class LanguageSwitcherService {
  LanguageSwitcherService(this.ref);

  final Ref ref;

  List<LanguageSwitcherEntity> getLanguages(Locale currentLocale) {
    return AppLocalizations.supportedLocales
        .map(
          (locale) => LanguageSwitcherEntity(
            languageCode: locale.languageCode,
            displayName: LocalizationUtils.getLocaleName(locale),
            isSelected: currentLocale.languageCode == locale.languageCode,
          ),
        )
        .toList();
  }

  Future<void> selectLanguage(String languageCode) async {
    await ref.read(persistentLocaleProvider.notifier).setLocale(Locale(languageCode));
  }
}

@riverpod
LanguageSwitcherService languageSwitcherService(Ref ref) {
  return LanguageSwitcherService(ref);
}
