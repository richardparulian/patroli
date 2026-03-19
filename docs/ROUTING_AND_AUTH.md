# Routing And Auth

Dokumen ini menjelaskan routing aplikasi dan bagaimana auth guard bekerja saat ini.

## Source Of Truth

File utama:
- `lib/app/router/app_router.dart`
- `lib/app/constants/app_routes.dart`

## Route Utama

Path yang aktif saat ini:
- `/` -> splash
- `/login` -> login
- `/home` -> home
- `/home/history` -> report history
- `/home/history/report_detail` -> report detail
- `/home/settings` -> settings
- `/home/settings/language_switcher` -> language switcher
- `/home/scan_qr` -> scan QR
- `/home/check_in` -> check-in
- `/home/visit` -> visit
- `/home/check_out` -> check-out
- `/home/image_preview` -> preview image

## Global Auth Redirect

Guard auth berada di `GoRouter.redirect` global.

Rule saat ini:
- jika `session == null` dan path bukan splash/login -> redirect ke login
- jika `session != null` dan sedang di login -> redirect ke home
- splash dibiarkan lewat untuk bootstrap awal

Dependency utama:
- `authSessionProvider`
- router refresh notifier

## Session Source

Session dibaca dari:
- `lib/features/auth/application/providers/auth_session_provider.dart`

Logout sinkronisasi dilakukan oleh:
- `lib/features/auth/application/services/auth_logout_service.dart`
- `lib/features/auth/application/services/auth_session_sync_provider.dart`

## Logout Flow

Flow logout dari home saat ini:
1. user tap tombol logout
2. dialog konfirmasi muncul
3. `authLogoutProvider.notifier.runLogout()` dipanggil
4. logout use case dijalankan
5. storage/token dibersihkan lewat `AuthSessionSyncService.forceLogout()`
6. session provider di-clear
7. UI melakukan `context.go(AppRoutes.login)` saat result sukses
8. global router guard menjaga konsistensi state session vs route

## Route-Scoped Provider Overrides

Beberapa route membuat `ProviderScope` sendiri untuk state per flow.

Contoh:
- check-in route override `checkInProvider`
- visit route override provider visit create dan attention
- check-out route override `checkOutProvider`

Tujuan:
- state flow terisolasi per route
- lifecycle provider mengikuti screen/flow terkait

## Error Route

Router punya `errorBuilder` yang menampilkan halaman 404 sederhana dengan localization.

## Maintenance Notes

Saat mengubah routing/auth:
- update `AppRoutes`
- update route registration di `app_router.dart`
- cek redirect global
- cek route args dan `state.extra`
- cek regression test auth/router yang relevan

Regression test yang sudah ada:
- `test/features/home/presentation/screens/home_logout_redirect_test.dart`
- `test/features/auth/presentation/router/auth_router_redirect_test.dart`
