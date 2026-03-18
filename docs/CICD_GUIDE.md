# CI/CD Guide

Dokumen ini menjelaskan pipeline CI yang aktif di repo saat ini.

## Workflow Aktif

File workflow utama:
- `.github/workflows/flutter_ci.yml`

Workflow sekarang dibagi menjadi dua job:

### `ci-test`

Tujuan:
- smoke/core verification yang lebih cepat untuk PR

Menjalankan:
- format check
- `make ci-test`

Isi `make ci-test` saat ini:
- `install`
- `generate-code`
- `test-core-features`
- `test-generators`
- `test-localization`

### `ci-build`

Tujuan:
- full verification setelah `ci-test` lolos

Dependency:
- `needs: ci-test`

Menjalankan:
- format check
- `make ci-build`

Isi `make ci-build` saat ini:
- `install`
- `generate-code`
- `analyze`
- `test`
- `test-generators`
- `test-localization`

## Cache

Workflow memakai:
- cache Flutter SDK via `subosito/flutter-action`
- cache dependency `pub` via `actions/cache`

Cache key dependency berbasis:
- `pubspec.lock`

## Validasi Workflow

Repo punya target khusus:

```bash
make ci-validate
```

Target ini memastikan:
- job `ci-test` ada
- job `ci-build` ada
- `ci-build` bergantung pada `ci-test`

## Git Hooks Lokal

Hook lokal memakai `.githooks` dan bisa diaktifkan dengan:

```bash
make hooks-install
```

Hook yang aktif:
- `pre-commit`
  - format check untuk file Dart staged
  - analyze untuk file Dart staged di `lib/` atau `test/`
- `pre-push`
  - `make ci-validate`

Cek status hook:

```bash
make hooks-status
```

## Target Berguna

- `make ci-test`
- `make ci-build`
- `make ci-quality`
- `make ci-validate`

## Catatan

- CI lokal dan GitHub Actions sekarang sama-sama memakai `Makefile` sebagai source of truth.
- Jika logic pipeline berubah, update `Makefile` dulu, lalu sesuaikan workflow bila perlu.
