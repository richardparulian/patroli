# Generator Guide

Dokumen ini menjelaskan generator yang dipakai untuk scaffolding feature baru.

## Generator yang Aktif

Ada dua generator yang dijaga tetap sinkron:
- shell generator: `generate_feature.sh`
- dart generator: `lib/core/cli/feature_generator.dart`

Guardrail sinkronisasi:
- `test/core/cli/feature_generators_smoke_test.dart`

## Tujuan Generator

Generator dipakai untuk membuat feature baru dengan shape yang sesuai repo saat ini.

Output target:
- data layer tanpa provider
- application layer untuk wiring dan service
- presentation layer untuk UI state dan screen

## Struktur Output

Shape umum hasil generator:

```text
lib/features/<feature>/
├── data/
│   ├── datasources/
│   ├── dtos/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── application/
│   ├── providers/
│   └── services/
└── presentation/
    ├── providers/
    └── screens/
```

## Command

### Shell Generator

```bash
./generate_feature.sh --name my_feature
```

Opsi:
- `--name <feature_name>`
- `--no-ui`

### Makefile Wrapper

```bash
make generate-feature FEATURE_NAME=my_feature
```

## File Penting yang Dihasilkan

Generator saat ini membuat file seperti:
- `<feature>_data_providers.dart`
- `<feature>_di_provider.dart`
- `<feature>_service.dart`
- `<feature>_provider.dart`
- `<feature>_screen.dart`

## Batasan Generator

Generator bukan generator domain final.

Artinya setelah generate biasanya masih perlu:
- mengganti entity generik menjadi entity bisnis nyata
- menyesuaikan request/response DTO
- mengubah repository contract agar sesuai use case produk
- menyesuaikan service/provider state agar sesuai flow nyata
- menambah route dan wiring UI bila fitur memang screen-facing

Contoh konkret dari repo ini:
- `language_switcher` awalnya scaffold generik
- lalu diubah manual menjadi feature lokal yang terhubung ke locale persistence dan daftar bahasa aktif

## Kapan Harus Update Generator

Update generator jika:
- shape feature repo berubah
- aturan provider organization berubah
- naming file berubah
- pattern service/provider baru jadi standar repo

Kalau generator diubah, wajib cek:
- `generate_feature.sh`
- `lib/core/cli/feature_generator.dart`
- `test/core/cli/feature_generators_smoke_test.dart`
- docs terkait generator

## Verifikasi Setelah Generate

Minimal jalankan:

```bash
make test-generators
```

Jika feature baru benar-benar dipakai di app, lanjutkan dengan:
- codegen
- analyze
- test yang relevan

## Rule Praktis

- jangan taruh provider Riverpod di data layer hasil generate
- jangan anggap output generator sudah siap produksi tanpa penyesuaian domain
- jangan ubah shape generator tanpa memperbarui smoke test
