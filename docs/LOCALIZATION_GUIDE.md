# Localization Guide

Panduan ini menjelaskan localization yang aktif di proyek ini, bukan setup template lama.

## Locale Aktif

Saat ini locale yang didukung aplikasi:
- `en`
- `id`

Sumber utamanya ada di:
- `lib/l10n/l10n.dart`
- `lib/l10n/app_localizations_delegate.dart`

## Arsitektur Saat Ini

Proyek ini memakai dua lapis localization yang hidup berdampingan:

1. Flutter localization delegates dan generated resources di `lib/gen/l10n/`
2. Manual translation map di `lib/l10n/l10n.dart`

Praktiknya di codebase saat ini:
- visible string banyak memakai `context.tr(...)` dan `context.trParams(...)`
- custom key tambahan dikelola di manual map
- beberapa generated ARB key tetap ada untuk area yang memang sudah memakai generator

## Boundary Rule

Localization dianggap concern `application/presentation`.

Artinya:
- `domain/` dan `data/` tidak boleh melakukan translation lookup
- mapping error lama ke localized message dilakukan di boundary aplikasi, terutama lewat:
  - `lib/app/localization/localized_message.dart`

## Menambah atau Mengubah String

Untuk custom map yang dipakai saat ini:
1. Tambahkan key ke `localizedValues['en']`
2. Tambahkan padanan key yang sama ke `localizedValues['id']`
3. Gunakan key itu di UI lewat `context.tr(...)` atau `context.trParams(...)`

Aturan key:
- custom key harus `snake_case`

## Menambah Locale Baru

Secara teknis langkah minimumnya:
1. tambah `Locale(...)` ke `AppLocalizations.supportedLocales`
2. tambah map terjemahan di `lib/l10n/l10n.dart`
3. tambah nama bahasa di `LocalizationUtils.getLocaleName()`
4. update selector/screen jika ada behavior khusus

Catatan:
- saat ini produk memang dibatasi ke `en` dan `id`
- jangan tambahkan locale baru tanpa memastikan produk memang membutuhkannya

## Testing

Guardrail yang sudah ada:

```bash
make test-localization
```

Yang dicek antara lain:
- key custom tetap `snake_case`
- key `en` dan `id` tetap selaras
- localized message mapper tidak drift

## Bahasa Switcher

Flow ganti bahasa saat ini ada di:
- `lib/features/language_switcher/`
- `lib/features/settings/presentation/screens/settings_screen.dart`

State locale dipersist melalui provider aplikasi dan dipakai ulang saat startup.
