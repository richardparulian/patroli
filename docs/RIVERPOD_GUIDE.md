---
title: Riverpod Guide
---

# Riverpod Guide

Dokumen ini menjelaskan konvensi state management `Riverpod` yang dipakai di proyek ini setelah refactor flow provider pada fitur inti.

## 1. Tujuan

Target utama penggunaan `Riverpod` di proyek ini:
- dependency injection yang eksplisit
- owner state yang jelas per layar atau flow
- screen fokus ke render dan side effect ringan
- orchestration async tidak tercecer di widget

## 2. Default Shape

Gunakan pembagian berikut:
- `application/providers/*_data_providers.dart`
  untuk datasource dan repository wiring
- `application/providers/*_di_provider.dart`
  untuk use case wiring
- `application/services/*_service.dart`
  untuk orchestration reusable lintas provider atau use case
- `presentation/providers/*_flow_provider.dart`
  untuk state layar atau flow multi-step
- `presentation/providers/*_provider.dart`
  untuk state sederhana yang tidak butuh flow controller penuh

## 3. Ownership Rules

### Screen
Screen seharusnya:
- render state
- mengirim user intent ke provider
- listen side effect seperti dialog, snackbar, dan navigation

Screen sebaiknya tidak:
- mengorkestrasi upload lalu submit lalu retry sendiri
- menyimpan source of truth async state yang seharusnya hidup di provider
- memanggil banyak provider berbeda untuk satu flow jika itu bisa dipusatkan

### Flow Provider
`*_flow_provider.dart` adalah owner state untuk flow yang punya beberapa fase.

Contoh cocok:
- `check_in`
- `check_out`
- `scan_qr`
- `visit`
- `home`
- `reports`
- `login`

Flow provider seharusnya memegang:
- state async utama
- state transient UI yang memang bagian dari flow
- event utama seperti `submit`, `refresh`, `retry`, `retake`, `fetchAttention`

### Service
Service dipakai saat logic masih reusable walaupun nanti dipanggil dari flow provider.

Contoh:
- upload file / pre-sign
- submit check-in / check-out
- login / logout
- fetch reports

Rule praktis:
- kalau logic bisa dipakai ulang lintas provider atau lintas screen, taruh di service
- kalau logic adalah sequencing state khusus satu layar, taruh di flow provider

## 4. Kapan Pakai Flow Provider

Gunakan flow provider jika salah satu kondisi ini terpenuhi:
- flow punya lebih dari satu fase async
- ada retry, reset, atau step progression
- screen mulai membaca 2 provider atau lebih untuk menyelesaikan satu user journey
- screen mulai menyimpan state operasional seperti `isProcessing`, `selectedImage`, `submitResult`

Contoh state yang cocok untuk flow provider:
- selfie image
- upload state
- submit state
- permission state
- scanner processing state
- dashboard refresh state

## 5. Kapan Provider Sederhana Masih Cukup

Provider sederhana masih layak jika:
- state benar-benar kecil dan lokal
- hanya boolean atau value tunggal
- tidak ada sequencing multi-step

Contoh:
- theme mode
- locale persistence
- accessibility settings
- feature flags

Kalau provider sederhana mulai berkembang menjadi:
- `Loading`
- `Error`
- `Success`
- plus beberapa flag lain

maka evaluasi apakah ia harus dinaikkan menjadi flow provider.

## 6. State Shape

### Gunakan `ResultState<T>` untuk:
- async operation tunggal
- state yang memang hanya `idle/loading/success/error`

### Gunakan state object khusus untuk:
- flow multi-step
- layar yang punya beberapa state berbeda sekaligus
- kombinasi beberapa concern seperti upload, submit, permission, carousel index

Contoh:
- `CheckInFlowState`
- `CheckOutFlowState`
- `ScanQrFlowState`
- `VisitFlowState`
- `HomeFlowState`
- `ReportsFlowState`
- `LoginFlowState`

## 7. Naming Convention

### Provider
- flow provider: `<feature>FlowProvider`
- provider sederhana: nama sesuai concern yang jelas
- hindari nama generik seperti `uploadFileProvider` jika ownership-nya spesifik

Contoh yang disarankan:
- `checkInFlowProvider`
- `checkOutFlowProvider`
- `scanQrFlowProvider`
- `visitAttentionFlowProvider`
- `homeFlowProvider`
- `loginFlowProvider`

### Notifier
- `<Feature>FlowNotifier`
- `<Concern>Notifier` hanya untuk provider sederhana

### Method
Nama method harus menggambarkan intent, bukan implementasi samar.

Gunakan:
- `submit`
- `refresh`
- `retryUpload`
- `retake`
- `fetchAttention`
- `handleScannedCode`
- `togglePasswordVisibility`

Hindari:
- `runX` untuk method yang sebenarnya terlalu generik atau ambigu
- nama yang menyesatkan seperti `runCheckIn()` jika sebenarnya hanya upload selfie

## 8. Lifecycle Rules

Gunakan `autoDispose` untuk:
- state yang lifecycle-nya mengikuti screen
- flow provider layar
- transient state seperti upload atau form submission

Gunakan `keepAlive` untuk:
- auth session
- bootstrap app
- service global yang memang perlu stabil
- provider app-wide seperti theme/locale bila memang dibutuhkan lintas layar

Default praktis:
- presentation flow provider: `autoDispose`
- application service global: `keepAlive` bila punya alasan jelas

## 9. Localization Rules

Provider presentasi sebaiknya tidak menyimpan string final yang sudah diterjemahkan jika state itu adalah validation atau machine state.

Gunakan:
- error key
- code
- enum

Lalu terjemahkan di UI.

Contoh:
- `visitFormProvider` menyimpan `errorKey`
- widget memanggil `context.tr(errorKey)`

Pengecualian:
- service boundary yang memang mengubah failure backend menjadi message aman untuk UI

## 10. Testing Rules

### Wajib ditest untuk flow provider
- state transition sukses
- state transition gagal
- retry/reset/refresh behavior
- side effect penting yang diekspos sebagai state

### Widget test
Gunakan widget test untuk:
- navigation
- dialog
- screen wiring ke provider

### Unit/provider test
Gunakan provider test untuk:
- state machine
- orchestration
- result mapping

Rule praktis:
- logic state jangan hanya diuji lewat widget test bila bisa diuji langsung di provider

## 11. Anti-Patterns

Hindari pola berikut:
- screen membaca 3 provider untuk menyelesaikan satu flow
- provider pass-through yang hanya `Loading -> service -> result` tanpa ownership nyata
- provider presentasi menyimpan string localized final untuk validation state
- override route-scoped provider jika screen sudah punya flow provider yang cukup
- menyebar state satu layar ke provider berbeda tanpa alasan yang kuat

## 12. Current North Star

Target arsitektur Riverpod proyek ini:
- satu flow penting = satu owner state utama
- screen tipis
- service reusable
- provider naming eksplisit
- lifecycle dapat diprediksi
- test provider sebagai guardrail utama

## 13. Checklist Saat Menambah Fitur Baru

Sebelum membuat provider baru, cek:
- apakah ini state layar atau state global
- apakah flow-nya multi-step
- apakah `ResultState<T>` cukup
- apakah screen akan membaca lebih dari satu provider untuk flow yang sama
- apakah error harus berupa key, message, atau failure
- apakah provider ini seharusnya `autoDispose` atau `keepAlive`

Kalau jawaban flow-nya kompleks, mulai dari `*_flow_provider.dart`.
