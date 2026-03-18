import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_switcher_entity.freezed.dart';

@freezed
abstract class LanguageSwitcherEntity with _$LanguageSwitcherEntity {
  const factory LanguageSwitcherEntity({
    required String languageCode,
    required String displayName,
    required bool isSelected,
  }) = _LanguageSwitcherEntity;
}
