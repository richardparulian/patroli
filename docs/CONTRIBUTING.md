# Contributing

Dokumen ini menjelaskan ekspektasi kontribusi untuk repo ini.

## Prinsip Umum

Saat mengubah codebase:
- jaga arsitektur tetap konsisten
- update test bila ada regression/fix penting
- update docs jika perilaku atau tooling berubah
- hindari meninggalkan mismatch antara generator, docs, dan implementasi runtime

## Development Setup

Setup minimal:

```bash
make install
make setup-dev
make generate-code
```

Cek dasar sebelum PR:

```bash
make analyze
make test
make test-generators
make test-localization
```

## Arsitektur dan Struktur

Sebelum menambah feature atau refactor besar, baca:
- `docs/ARCHITECTURE.md`
- `docs/ARCHITECTURE_GUIDE.md`
- `docs/RIVERPOD_GUIDE.md`
- `docs/CODING_STANDARDS.md`

Rule penting:
- jangan menaruh provider Riverpod di data layer
- jangan tambah string user-facing hardcoded di UI baru
- jangan menaruh logic bisnis kompleks di screen/widget

## Testing Expectations

Tambahkan atau update test bila:
- memperbaiki bug regression
- mengubah flow auth, routing, localization, atau generator
- mengubah state transition provider/service penting

Gunakan target granular saat perlu:
- `make test-auth`
- `make test-home`
- `make test-settings`
- `make test-check-in`
- `make test-check-out`
- `make test-visits`
- `make test-scan-qr`
- `make test-reports`
- `make test-core-features`

## Git Hooks Lokal

Repo ini mendukung hook lokal berbasis `.githooks`.

Install:

```bash
make hooks-install
```

Cek status:

```bash
make hooks-status
```

Saat ini:
- `pre-commit` memeriksa format dan analyze scoped ke file staged
- `pre-push` memvalidasi struktur workflow CI

## Pull Request Checklist

Sebelum membuka PR, pastikan:
- perubahan punya alasan yang jelas
- test relevan sudah dijalankan
- docs sudah diupdate bila diperlukan
- perubahan generator ikut dijaga oleh smoke test jika applicable
- perubahan CI/Makefile tetap sinkron

## Commit Messages

Gunakan commit message yang deskriptif dan singkat.

Contoh:
- `fix(auth): redirect to login after logout`
- `chore(tooling): add git hooks and granular Flutter test targets`
- `docs: align architecture docs with current project structure`
