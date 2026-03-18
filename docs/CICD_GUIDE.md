# CI/CD Guide

Dokumen ini menjelaskan pipeline CI dan tooling release yang aktif di repo saat ini.

## Jalur Otomasi yang Ada

Repo ini saat ini punya dua jalur berbeda:
- GitHub Actions untuk CI utama
- Fastlane untuk build/deploy mobile release

Keduanya punya peran berbeda.

## 1. GitHub Actions CI

Workflow utama:
- `.github/workflows/flutter_ci.yml`

Job yang aktif:

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

## 2. Fastlane Release Tooling

Fastlane file:
- `fastlane/Fastfile`

Tujuannya:
- build Android
- deploy Android ke Google Play
- build iOS
- deploy iOS ke TestFlight

### Environment Files

Fastlane saat ini membaca environment dari:
- `lib/config/environment/.env.dev`
- `lib/config/environment/.env.staging`
- `lib/config/environment/.env.prod`

Key yang saat ini dipakai lane Fastlane:
- `APP_VERSION_NAME`
- `APP_VERSION_CODE`
- `APPLE_APP_ID` untuk iOS deploy

Catatan:
- key-key tersebut belum terlihat di file `.env` yang ada sekarang
- sebelum lane release dipakai penuh, environment release perlu dilengkapi

### Android Lanes

Tersedia:
- `fastlane android build env:development`
- `fastlane android build env:staging`
- `fastlane android build env:production`
- `fastlane android deploy env:production track:internal`

Catatan:
- lane Android tidak lagi mencoba patch `build.gradle.kts` untuk version code/version name
- versi Android dianggap dikelola oleh konfigurasi Flutter/app yang aktif

### iOS Lanes

Tersedia:
- `fastlane ios build env:development`
- `fastlane ios build env:staging`
- `fastlane ios build env:production`
- `fastlane ios deploy env:production`

Catatan:
- lane iOS masih memakai increment version/build number via Fastlane
- jalur ini tetap perlu diuji manual sebelum dianggap release source of truth penuh

## 3. Ruby Setup

Repo sekarang punya `Gemfile` minimal untuk Fastlane:
- `fastlane`
- `dotenv`

Setup yang disarankan:

```bash
bundle install
bundle exec fastlane android build env:development
```

Untuk deploy:

```bash
bundle exec fastlane android deploy env:production track:internal
bundle exec fastlane ios deploy env:production
```

## 4. Cache dan Validasi CI

Workflow GitHub Actions memakai:
- cache Flutter SDK via `subosito/flutter-action`
- cache dependency `pub` via `actions/cache`

Repo juga punya validasi workflow:

```bash
make ci-validate
```

Target ini memastikan:
- job `ci-test` ada
- job `ci-build` ada
- `ci-build` bergantung pada `ci-test`

## 5. Git Hooks Lokal

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

## 6. Target Berguna

- `make ci-test`
- `make ci-build`
- `make ci-quality`
- `make ci-validate`
- `make generate-code`
- `make test`

## 7. Status Praktis

Status saat ini:
- GitHub Actions adalah source of truth untuk CI harian
- Fastlane adalah tooling release/deployment, bukan jalur CI utama
- bila flow release ingin diandalkan penuh, lane Fastlane tetap perlu diuji manual secara periodik
