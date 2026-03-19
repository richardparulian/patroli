# Getting Started

Panduan ini ditulis untuk proyek `patroli_v2` yang ada di repo ini.

## Prasyarat

- Flutter SDK terpasang dan `flutter doctor` bersih secukupnya
- Dart SDK mengikuti versi Flutter aktif
- Xcode/Android Studio bila ingin build mobile native

## Setup Awal

```bash
make install
make setup-dev
make generate-code
```

Alternatif manual:

```bash
flutter pub get
cp lib/config/environment/.env.dev lib/config/environment/.env
dart run build_runner build --delete-conflicting-outputs
```

## Menjalankan App

Target yang paling umum:

```bash
make run-android
make ios-sim-open
make run-ios
make run-mac
make run-web
```

Atau langsung:

```bash
flutter run
```

## Command Harian

- Install dependency: `make install`
- Generate code: `make generate-code`
- Analyze: `make analyze`
- Full test: `make test`
- Core feature tests: `make test-core-features`
- Localization tests: `make test-localization`
- Generator smoke tests: `make test-generators`

## Environment

File environment aktif ada di:
- `lib/config/environment/.env`

Helper yang tersedia:
- `make setup-dev`
- `make setup-staging`
- `make setup-prod`

## Feature Generator

Untuk generate feature baru:

```bash
./generate_feature.sh --name my_feature
```

Atau via `Makefile`:

```bash
make generate-feature FEATURE_NAME=my_feature
```

Generator saat ini mengikuti pola repo:
- `application/providers/*_data_providers.dart`
- `application/providers/*_di_provider.dart`
- `application/services/*_service.dart`
- `presentation/providers/*_provider.dart`
- `presentation/screens/*_screen.dart`

## Git Hooks Lokal

Repo ini sudah mendukung hook lokal via `.githooks`.

Install:

```bash
make hooks-install
```

Cek status:

```bash
make hooks-status
```

Hook aktif saat ini:
- `pre-commit`: format check + analyze untuk file Dart yang di-stage
- `pre-push`: validasi workflow CI
