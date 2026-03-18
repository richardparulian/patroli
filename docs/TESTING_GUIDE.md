# Testing Guide

Dokumen ini menjelaskan strategi test yang dipakai di repo saat ini.

## Layer Test yang Sudah Ada

Test yang aktif di repo saat ini mencakup:
- domain/use case tests
- repository tests
- application service tests
- provider tests
- widget regression test tertentu
- localization guardrail tests
- feature generator smoke tests

## Guardrail Penting

### Localization

Path:
- `test/app/localization/localization_keys_test.dart`
- `test/app/localization/localized_message_test.dart`

Menjaga:
- custom key tetap `snake_case`
- key `en` dan `id` tetap selaras
- mapper localized message tidak drift

Jalankan:

```bash
make test-localization
```

### Feature Generator

Path:
- `test/core/cli/feature_generators_smoke_test.dart`

Menjaga:
- shell generator dan dart generator tetap menghasilkan struktur yang benar
- provider wiring tetap di `application/`
- output codegen pattern tidak drift

Jalankan:

```bash
make test-generators
```

### Logout Redirect Regression

Path:
- `test/features/home/presentation/screens/home_logout_redirect_test.dart`

Menjaga:
- logout dari home tetap mengarah ke login

Jalankan:

```bash
make test-home-logout
```

## Makefile Targets

### Full Suite

```bash
make test
```

### Core Fast Suite

```bash
make test-core-features
```

Target ini dipakai di jalur `ci-test` untuk smoke/core verification.

### Granular Targets

Tersedia target granular seperti:
- `make test-auth`
- `make test-home`
- `make test-home-logout`
- `make test-reports`
- `make test-check-in`
- `make test-check-out`
- `make test-visits`
- `make test-scan-qr`
- `make test-settings`
- `make test-language-switcher`

Catatan penting:
- beberapa target granular hanya berguna jika folder test terkait memang sudah ada isi test-nya
- gunakan `find test -type f` bila ragu terhadap path test yang benar-benar tersedia

## Kapan Menambah Test

Tambahkan atau update test bila:
- memperbaiki bug regression nyata
- mengubah auth flow
- mengubah router redirect
- mengubah localization behavior
- mengubah generator output
- mengubah provider/service state transition penting

## Prioritas Test Saat Mengubah Area Tertentu

### Auth / Router

Minimal cek:
- auth provider/service tests
- logout redirect regression test

### Localization

Minimal cek:
- `make test-localization`
- test widget yang merender string terkait bila ada

### Generator

Minimal cek:
- `make test-generators`

### Docs-only Changes

Biasanya tidak perlu full test, kecuali docs perubahan itu dibarengi perubahan config/runtime seperti localization assets.

## CI Split

Pipeline saat ini:
- `make ci-test`
- `make ci-build`

`ci-test` fokus ke:
- generate-code
- core feature tests
- generator smoke tests
- localization tests

`ci-build` fokus ke:
- generate-code
- analyze
- full test suite
- generator smoke tests
- localization tests
