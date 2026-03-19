# Docs

Dokumentasi di folder ini sudah dirapikan untuk fokus ke codebase `patroli_v2` yang aktif, bukan template asalnya.

## Guide Aktif

- `GETTING_STARTED.md`
  Ringkasan setup proyek, generate code, cara run, dan command harian yang dipakai.
- `ARCHITECTURE.md`
  Gambaran arsitektur aktual: `app`, `core`, feature-first modules, dan boundary Riverpod.
- `ARCHITECTURE_GUIDE.md`
  Aturan arsitektur yang lebih ketat: dependency rule, localization boundary, dan testing strategy.
- `RIVERPOD_GUIDE.md`
  Konvensi state management Riverpod: flow provider, ownership state, lifecycle, dan anti-pattern.
- `DEPENDENCY_UPGRADE_GUIDE.md`
  Aturan kapan upgrade Flutter dan dependency layak dilakukan, plus level verifikasinya.
- `CODING_STANDARDS.md`
  Konvensi coding yang dipakai di repo ini.
- `LOCALIZATION_GUIDE.md`
  Cara kerja localization saat ini, termasuk locale aktif, boundary aplikasi, dan update translation.
- `FEATURE_FLOWS.md`
  Ringkasan flow fitur bisnis utama dan hubungan antar screen.
- `ROUTING_AND_AUTH.md`
  Penjelasan route aktif, auth guard, dan logout/session flow.
- `TESTING_GUIDE.md`
  Strategi test, guardrail aktif, dan cara memilih target test.
- `GENERATOR_GUIDE.md`
  Shape generator feature, batasan, dan cara memeliharanya.
- `CICD_GUIDE.md`
  Pipeline CI yang aktif, target `Makefile`, dan git hooks lokal.
- `TOOLS.md`
  Script dan target `Makefile` yang relevan untuk kerja harian.
- `CONTRIBUTING.md`
  Aturan kontribusi umum.

## Struktur Docs

```text
docs/
├── README.md
├── GETTING_STARTED.md
├── ARCHITECTURE.md
├── ARCHITECTURE_GUIDE.md
├── RIVERPOD_GUIDE.md
├── DEPENDENCY_UPGRADE_GUIDE.md
├── CODING_STANDARDS.md
├── LOCALIZATION_GUIDE.md
├── FEATURE_FLOWS.md
├── ROUTING_AND_AUTH.md
├── TESTING_GUIDE.md
├── GENERATOR_GUIDE.md
├── CICD_GUIDE.md
├── TOOLS.md
└── CONTRIBUTING.md
```

## Catatan

- `ARCHITECTURE_GUIDE.md` tetap dipertahankan sebagai dokumen aturan yang lebih ketat daripada `ARCHITECTURE.md`.

## Static-Site Tooling Status

Folder `docs/` masih menyimpan tooling static-site berikut:
- `_config.yml`
- `_layouts/default.html`
- `build_site.py`
- `build_docs.sh`
- `assets/`

Statusnya saat ini:
- bukan bagian dari runtime aplikasi
- bukan dependency CI utama
- dipertahankan hanya jika tim masih ingin mem-publish dokumentasi sebagai static site

Kalau tim memutuskan dokumentasi cukup dikelola sebagai Markdown biasa di repo, tooling ini bisa dihapus pada cleanup berikutnya.
