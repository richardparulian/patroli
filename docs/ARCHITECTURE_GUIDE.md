---
title: Architecture Guide
---

# Architecture Guide

Dokumen ini adalah aturan arsitektur yang lebih ketat daripada `docs/ARCHITECTURE.md`.

## 1. Dependency Rule

Rule utama:
- dependency hanya boleh mengarah ke dalam
- domain tidak tahu Flutter
- data tahu domain, tapi tidak tahu UI
- presentation boleh memakai application/domain, tapi tidak menaruh logic data access mentah di screen

## 2. Layer Breakdown

### Domain Layer
**Path:** `lib/features/<feature>/domain/`

Isi utama:
- entities
- repository contracts
- use cases

Aturan:
- pure Dart
- tidak import Flutter
- tidak bergantung pada data implementation
- tidak melakukan localization lookup

### Data Layer
**Path:** `lib/features/<feature>/data/`

Isi utama:
- datasources
- DTO / models
- repository implementations

Aturan:
- implement repository contract dari domain
- mapping exception ke `Failure` dilakukan di sini atau pada boundary yang relevan
- tidak menaruh provider Riverpod di data layer
- sebaiknya tetap pure Dart dan menghindari import Flutter

### Application Layer
**Path:** `lib/features/<feature>/application/`

Isi utama:
- `providers/*_data_providers.dart`
- `providers/*_di_provider.dart`
- `services/*_service.dart`

Tanggung jawab:
- wiring datasource, repository, dan use case
- orchestration async yang terlalu berat jika ditaruh langsung di UI provider
- boundary yang sah untuk message mapping ke localization

### Presentation Layer
**Path:** `lib/features/<feature>/presentation/`

Isi utama:
- screens
- widgets
- UI providers

Aturan:
- screen harus fokus ke rendering dan user interaction
- visible string harus lewat localization
- provider UI membaca use case/service dari application layer

## 3. Riverpod Organization

Dokumen konvensi detailnya ada di `docs/RIVERPOD_GUIDE.md`.

Pattern yang dipakai repo saat ini:

### Data DI
File umum:
- `application/providers/<feature>_data_providers.dart`

Dipakai untuk:
- data source provider
- repository provider

### Use Case DI
File umum:
- `application/providers/<feature>_di_provider.dart`

Dipakai untuk:
- use case provider
- dependency wiring tambahan yang masih level feature

### UI State
File umum:
- `presentation/providers/<feature>_provider.dart`

Dipakai untuk:
- async state UI
- form state
- screen-facing state transitions

### Services
File umum:
- `application/services/<feature>_service.dart`

Dipakai untuk:
- orchestration multi-step async flow
- operasi yang butuh koordinasi beberapa provider/use case
- boundary mapping error/message ke bentuk yang siap dipakai UI

## 4. Error Handling

Prinsip yang dipakai:
- domain tidak melempar exception sebagai flow utama
- gunakan `Either<Failure, T>` untuk flow bisnis yang relevan
- message yang keluar ke UI boleh dilokalisasi di application/presentation boundary

Untuk legacy/backend-facing message:
- gunakan `lib/app/localization/localized_message.dart`
- fallback ke raw message hanya jika belum ada mapping yang aman

## 5. Localization Boundary

Localization adalah concern `application/presentation`.

Aturan:
- `domain/` dan `data/` tidak boleh bergantung pada `BuildContext`
- `domain/` dan `data/` tidak boleh memanggil translation lookup
- visible string di widget harus memakai `context.tr(...)` atau `context.trParams(...)`
- custom key di `lib/l10n/l10n.dart` harus `snake_case`

## 6. Testing Strategy

### Domain / Data
Fokus:
- use case behavior
- repository success/failure mapping
- pure logic unit tests

### Application / Presentation
Fokus:
- provider state transition
- service orchestration
- widget regression untuk flow penting

Guardrail yang sudah ada di repo:
- generator smoke tests
- localization tests
- logout redirect regression test

## 7. Practical Rules

- jangan taruh provider Riverpod di data layer
- jangan pass `BuildContext` ke use case atau repository
- jangan taruh string user-facing hardcoded di screen baru
- kalau async flow rawan disposed, gunakan `ref.mounted`, cancellation, atau `keepAlive` dengan alasan yang jelas
- kalau generator feature berubah, update docs dan smoke test sekaligus
