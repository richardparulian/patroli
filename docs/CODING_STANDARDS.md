# Coding Standards

Dokumen ini merangkum aturan praktis yang dipakai di repo ini.

## Architecture Rules

- Domain harus pure Dart.
- Data layer tidak menaruh provider Riverpod.
- Localization adalah concern `application/presentation`, bukan `domain/data`.
- Jangan pass `BuildContext` ke use case, repository, atau data source.

## Riverpod Rules

- Gunakan codegen `@riverpod` untuk provider baru kecuali ada alasan kuat.
- Pisahkan wiring data ke `application/providers/*_data_providers.dart`.
- Pisahkan wiring use case ke `application/providers/*_di_provider.dart`.
- UI state ditempatkan di `presentation/providers/`.
- Untuk operasi async yang rawan disposed, gunakan `ref.mounted`, cancellation, atau `keepAlive` bila memang lifecycle-nya harus tahan.

## Localization Rules

- Semua string yang terlihat user harus lewat localization.
- Custom key di `lib/l10n/l10n.dart` harus `snake_case`.
- Error lama atau backend-facing message dimapping di `lib/app/localization/localized_message.dart`.

## UI Rules

- Untuk layout responsif, gunakan `ScreenUtil` untuk spacing/size yang memang perlu diskalakan.
- Jangan pakai `ScreenUtil` untuk mengganti fungsi `SafeArea` atau `MediaQuery` yang berkaitan dengan notch/status bar.
- Untuk menghindari overflow, prioritaskan `Expanded`, `Flexible`, `ellipsis`, dan constraint yang benar sebelum menambah ukuran parent.

## Imports

- Gunakan package import untuk crossing module boundary.
- Gunakan relative import hanya jika tetap jelas dan terbatas dalam area yang sama.
- Hindari import yang tidak dipakai.

## Testing Rules

- Tambah test saat memperbaiki regression yang nyata.
- Gunakan target `Makefile` yang granular saat debug test per fitur.
- Jalur penting yang sudah punya guardrail:
  - generator smoke tests
  - localization tests
  - logout redirect regression test

## Docs Rules

- Dokumentasi di `docs/` harus menggambarkan repo saat ini, bukan template lama.
- Guide baru yang masih eksploratif atau tidak lagi relevan pindahkan ke `docs/archive/`.
