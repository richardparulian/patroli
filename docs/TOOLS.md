# Tools

Dokumen ini merangkum script dan helper yang relevan untuk repo ini.

## Script Root

Script yang tersedia di root repo:
- `generate_feature.sh`
- `generate_icons.sh`
- `generate_language.sh`
- `rename_app.sh`
- `test_generator.sh`

## Feature Generator

Gunakan:

```bash
./generate_feature.sh --name my_feature
```

Opsi yang didukung:
- `--name <feature_name>`
- `--no-ui`

Alternatif via `Makefile`:

```bash
make generate-feature FEATURE_NAME=my_feature
```

Generator sekarang mengikuti pola repo:
- data layer tetap bersih dari provider
- provider wiring ada di `application/providers/`
- orchestration async ada di `application/services/`
- UI state ada di `presentation/providers/`

Guardrail generator:

```bash
make test-generators
```

## Localization Helper

Script bahasa yang tersedia:

```bash
./generate_language.sh list
./generate_language.sh add id
./generate_language.sh check
./generate_language.sh generate
```

Alternatif via `Makefile` untuk penambahan bahasa:

```bash
make generate-language LANGUAGE_CODE=id
```

Catatan penting:
- script ini bekerja di layer ARB / helper, bukan source of truth akhir untuk locale produk
- locale aktif aplikasi tetap ditentukan oleh codebase, terutama `lib/l10n/l10n.dart`

## App Utilities

- rename app: `./rename_app.sh`
- generate icons: `./generate_icons.sh`
- generate test scaffolding: `./test_generator.sh feature_name`

## Makefile Targets Penting

### Setup

- `make install`
- `make setup`
- `make setup-dev`
- `make generate-code`

### Run

- `make run-android`
- `make run-ios`
- `make run-mac`
- `make run-web`

### Test

- `make test`
- `make test-core-features`
- `make test-auth`
- `make test-home`
- `make test-home-logout`
- `make test-settings`
- `make test-language-switcher`
- `make test-check-in`
- `make test-check-out`
- `make test-visits`
- `make test-scan-qr`
- `make test-reports`
- `make test-generators`
- `make test-localization`

### CI / Hooks

- `make ci-test`
- `make ci-build`
- `make ci-validate`
- `make hooks-install`
- `make hooks-status`
- `make hooks-uninstall`

## Dokumentasi Site

Folder `docs/` masih menyimpan helper static-site:
- `build_docs.sh`
- `build_site.py`
- `_config.yml`

Tapi docs aktif tetap diprioritaskan dalam bentuk Markdown biasa di root `docs/`.
