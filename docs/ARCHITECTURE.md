# Architecture

Dokumen ini menjelaskan shape arsitektur aktual di proyek ini.

## Gambaran Besar

Proyek memakai kombinasi:
- feature-first folder organization
- Clean Architecture per fitur
- Riverpod untuk dependency injection dan state management
- `app/` sebagai composition layer yang mengikat framework, router, theme, localization, analytics, dan integrasi global lain

## Struktur Utama

```text
lib/
├── main.dart
├── app/
├── core/
├── features/
├── gen/
└── l10n/
```

### `lib/main.dart`

Titik masuk aplikasi.

Tanggung jawab utama:
- membuat `ProviderScope`
- override dependency global yang perlu di-bootstrap saat startup
- menjalankan `MyApp`

### `lib/app/`

Layer komposisi aplikasi.

Contoh isinya:
- `router/` untuk `GoRouter`
- `theme/` untuk mode tema dan persistence
- `localization/` untuk locale persistence dan message mapping
- `network/` untuk provider network bertingkat aplikasi
- `review/`, `analytics/`, `updates/`, `notifications/`

Rule praktis:
- `app/` boleh tahu Flutter dan Riverpod
- `app/` mengikat banyak modul sekaligus
- `app/` adalah boundary yang wajar untuk hal global lintas fitur

### `lib/core/`

Shared technical foundation.

Contoh isinya:
- `network/`
- `storage/`
- `error/`
- `providers/`
- `ui/`
- `utils/`
- `logging/`

Rule praktis:
- `core/` berisi utilitas dan infrastruktur reusable
- jangan isi `core/` dengan logic bisnis spesifik fitur

### `lib/features/`

Feature modules. Mayoritas fitur bisnis mengikuti shape berikut:

```text
features/<feature>/
├── application/
│   ├── providers/
│   └── services/
├── data/
├── domain/
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
```

Contoh fitur aktif:
- `auth`
- `check_in`
- `check_out`
- `reports`
- `scan_qr`
- `visits`
- `language_switcher`
- `settings`
- `home`

## Layer per Fitur

### Domain

Path umum: `lib/features/<feature>/domain/`

Isi:
- entities
- repository contracts
- use cases

Aturan:
- pure Dart
- tidak tergantung Flutter
- tidak tahu implementasi data source

### Data

Path umum: `lib/features/<feature>/data/`

Isi:
- data sources
- models / DTO
- repository implementation

Aturan:
- tahu domain contract
- tidak boleh jadi tempat provider Riverpod
- sebaiknya tetap pure Dart, tanpa import Flutter

### Application

Path umum: `lib/features/<feature>/application/`

Isi:
- `providers/*_data_providers.dart` untuk wiring datasource/repository
- `providers/*_di_provider.dart` untuk wiring use case
- `services/*_service.dart` untuk orchestration async

Aturan:
- ini layer penghubung yang sah antara data, domain, dan presentation
- localization mapping yang terkait UI boleh terjadi di sini, bukan di domain/data

### Presentation

Path umum: `lib/features/<feature>/presentation/`

Isi:
- screen
- widget
- provider state UI

Aturan:
- visible string harus lewat localization
- screen membaca provider Riverpod dan merender state

## Riverpod Scope

Riverpod dipakai untuk:
- dependency injection
- async state
- route-scoped override jika perlu
- global app state seperti theme, locale, auth session, dan router refresh

Pattern yang sedang dipakai di repo:
- codegen `@riverpod`
- provider wiring dipisah dari data layer
- service async yang sensitif lifecycle menggunakan `ref.mounted` atau `keepAlive` sesuai kebutuhan

## Localization Boundary

Rule yang sekarang dipakai:
- domain/data tidak melakukan translation lookup
- application/presentation bertanggung jawab memetakan message ke text localized
- visible string di widget harus lewat `context.tr(...)` atau `context.trParams(...)`

Dokumen detailnya ada di `ARCHITECTURE_GUIDE.md` dan `LOCALIZATION_GUIDE.md`.
