# Fastlane

Panduan singkat untuk menjalankan lane Fastlane di repo ini.

## Setup

Gunakan Bundler agar versi gem konsisten:

```bash
bundle install
```

Lihat lane yang tersedia:

```bash
bundle exec fastlane lanes
```

## Lane yang Tersedia

### Android

Build:

```bash
bundle exec fastlane android build env:development
bundle exec fastlane android build env:staging
bundle exec fastlane android build env:production
```

Deploy:

```bash
bundle exec fastlane android deploy env:production track:internal
```

### iOS

Build:

```bash
bundle exec fastlane ios build env:development
bundle exec fastlane ios build env:staging
bundle exec fastlane ios build env:production
```

Deploy:

```bash
bundle exec fastlane ios deploy env:production
```

## Environment Files

Fastlane membaca file berikut:
- `lib/config/environment/.env.dev`
- `lib/config/environment/.env.staging`
- `lib/config/environment/.env.prod`

## Key yang Dibutuhkan Fastlane

Saat ini `fastlane/Fastfile` membaca key berikut:
- `APP_VERSION_NAME`
- `APP_VERSION_CODE`
- `APPLE_APP_ID` untuk iOS deploy

Catatan audit saat ini:
- key tersebut belum ada di file `.env` yang aktif di repo
- sebelum menjalankan lane iOS atau flow versioning tertentu, key itu perlu ditambahkan ke environment yang sesuai

## Catatan Android

Lane Android saat ini:
- build APK debug untuk `development`
- build AAB release untuk `staging`/`production`
- tidak lagi patch `android/app/build.gradle.kts` untuk version code/version name

## Catatan iOS

Lane iOS saat ini:
- masih memakai Fastlane increment untuk version/build number
- deploy ke TestFlight butuh `APPLE_APP_ID` dan kredensial Apple yang valid

## Status Praktis

Fastlane di repo ini diposisikan sebagai tooling release/deployment, bukan jalur CI utama.
