# Docs

Dokumentasi di folder ini sudah dirapikan untuk fokus ke codebase `patroli_v2` yang aktif, bukan template asalnya.

## Guide Aktif

- `GETTING_STARTED.md`
  Ringkasan setup proyek, generate code, cara run, dan command harian yang dipakai.
- `ARCHITECTURE.md`
  Gambaran arsitektur aktual: `app`, `core`, feature-first modules, dan boundary Riverpod.
- `ARCHITECTURE_GUIDE.md`
  Aturan arsitektur yang lebih ketat: dependency rule, localization boundary, dan testing strategy.
- `CODING_STANDARDS.md`
  Konvensi coding yang dipakai di repo ini.
- `LOCALIZATION_GUIDE.md`
  Cara kerja localization saat ini, termasuk locale aktif, boundary aplikasi, dan update translation.
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
├── CODING_STANDARDS.md
├── LOCALIZATION_GUIDE.md
├── CICD_GUIDE.md
├── TOOLS.md
├── CONTRIBUTING.md
└── archive/
```

## Archive

Guide lama yang masih berisi konten template, marketing site, atau fitur yang belum relevan dipindahkan ke `docs/archive/`.

Tujuannya:
- root `docs/` tetap pendek dan mudah dinavigasi
- guide aktif tidak tercampur dengan referensi template lama
- histori dokumentasi lama tetap ada bila masih perlu dirujuk

## Catatan

- `ARCHITECTURE_GUIDE.md` tetap dipertahankan sebagai dokumen aturan yang lebih ketat daripada `ARCHITECTURE.md`.
- Beberapa file pendukung static-site seperti `_config.yml`, `_layouts/`, `build_site.py`, dan `build_docs.sh` tetap dibiarkan karena masih bisa dipakai bila dokumentasi ingin dipublish sebagai site.
