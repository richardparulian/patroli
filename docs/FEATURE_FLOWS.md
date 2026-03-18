# Feature Flows

Dokumen ini merangkum flow fitur yang aktif di aplikasi saat ini.

## Ringkasan Fitur Aktif

Flow utama yang terlihat dari aplikasi:
- auth
- home dashboard
- scan QR
- check-in
- visit/report creation
- report history/detail
- check-out
- settings
- language switcher

## 1. Auth Flow

Entry point utama:
- `SplashScreen`
- `LoginScreen`
- `authSessionProvider`

Alur:
1. app start di splash
2. bootstrap session membaca storage/token lokal
3. jika session ada, router mengarah ke home
4. jika session tidak ada, router mengarah ke login
5. login sukses menyimpan session dan membuka home
6. logout membersihkan session, token, dan mengarahkan user ke login

File penting:
- `lib/features/auth/`
- `lib/app/router/app_router.dart`
- `lib/features/auth/application/providers/auth_session_provider.dart`
- `lib/features/auth/application/services/auth_logout_service.dart`

## 2. Home Flow

Screen utama:
- `lib/features/home/presentation/screens/home_screen.dart`

Tanggung jawab:
- menampilkan greeting user
- menampilkan summary dashboard jumlah report
- entry point ke scan QR
- entry point ke history report
- entry point ke settings
- logout

Dashboard count memakai provider reports count.

## 3. Scan QR -> Check-In -> Visit -> Check-Out

Ini flow operasional inti aplikasi.

### Scan QR

Screen:
- `lib/features/scan_qr/presentation/screens/scan_qr_screen.dart`

Output penting:
- `ScanQrEntity`

Jika scan berhasil, user diarahkan ke flow berikutnya dengan data cabang hasil scan.

### Check-In

Screen:
- `lib/features/check_in/presentation/screens/check_in_screen.dart`

Input:
- `ScanQrEntity`

Tanggung jawab:
- selfie/verifikasi check-in
- submit konfirmasi awal kunjungan

Output penting:
- data hasil check-in untuk dipakai di visit flow

### Visit / Report Creation

Screen:
- `lib/features/visits/presentation/screens/visit_screen.dart`

Input:
- data scan QR
- data check-in
- report existing bila sedang melanjutkan flow tertentu

Tanggung jawab:
- isi kondisi cabang
- submit report visit

Output penting:
- report yang bisa muncul di history/detail dan dipakai di check-out

### Check-Out

Screen:
- `lib/features/check_out/presentation/screens/check_out_screen.dart`

Input:
- report id
- branch id
- branch name

Tanggung jawab:
- selfie/verifikasi keluar
- menutup visit/report flow

## 4. Reports Flow

Screen utama:
- `lib/features/reports/presentation/screens/reports_screen.dart`
- `lib/features/reports/presentation/screens/reports_detail_screen.dart`

Tanggung jawab:
- menampilkan history report
- melihat detail kondisi report
- menjadi titik review setelah visit/check-out

Home dashboard juga bergantung pada count report dari domain reports.

## 5. Settings Flow

Screen:
- `lib/features/settings/presentation/screens/settings_screen.dart`

Saat ini settings berisi:
- language selector
- theme mode selector

Theme mode yang tersedia:
- light
- dark
- system default

## 6. Language Switcher Flow

Screen:
- `lib/features/language_switcher/presentation/screens/language_switcher_screen.dart`

Tanggung jawab:
- menampilkan locale yang didukung produk
- menandai locale aktif
- menyimpan locale pilihan user lewat provider aplikasi

Saat ini locale aktif produk:
- `en`
- `id`

## 7. Flow Dependency Summary

Flow operasional utama secara sederhana:

```text
Splash -> Login/Home
Home -> Scan QR
Scan QR -> Check-In
Check-In -> Visit
Visit -> Reports / Check-Out
Settings -> Language / Theme
Logout -> Login
```

## 8. Maintenance Notes

Saat mengubah flow fitur:
- cek route di `lib/app/router/app_router.dart`
- cek route args bila flow membawa entity antar screen
- cek provider override per route untuk state yang route-scoped
- tambah/update regression test bila flow auth, localization, atau generator berubah
