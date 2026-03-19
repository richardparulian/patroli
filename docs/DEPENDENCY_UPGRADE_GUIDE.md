# Dependency Upgrade Guide

Panduan ini menjelaskan kapan dan bagaimana upgrade Flutter SDK maupun package
dependency sebaiknya dilakukan di proyek ini.

## Flutter SDK

- Jangan upgrade Flutter hanya karena ada versi baru.
- Upgrade Flutter hanya ketika:
  - ada bug framework atau tooling yang menghambat kerja
  - ada dependency penting yang mewajibkan baseline Flutter lebih baru
  - tim sepakat memindahkan baseline lokal dan CI ke versi baru

Setelah upgrade Flutter:

- jalankan `flutter doctor -v`
- jalankan `flutter pub get`
- jalankan `flutter analyze`
- jalankan subset test yang relevan untuk flow yang terdampak

## Upgrade Dependency Patch dan Minor

- Upgrade patch atau minor diperbolehkan jika:
  - tidak memicu perubahan API besar
  - memberi bug fix, stabilitas, atau compatibility improvement
- Lakukan dalam batch kecil, jangan sekaligus terlalu banyak.

Verifikasi minimum:

- `flutter analyze`
- test subset yang relevan dengan area terdampak

## Upgrade Dependency Major

- Jangan campur upgrade major dengan feature work.
- Wajib dipisah dalam branch atau PR tersendiri.
- Perlakukan upgrade major sebagai refactor terkontrol.

Dependency yang perlu perhatian ekstra di proyek ini:

- `flutter_riverpod`
- `riverpod`
- `riverpod_annotation`
- `riverpod_generator`
- `permission_handler`
- `flutter_dotenv`

## Kapan Upgrade Sebaiknya Ditahan

Jangan upgrade jika:

- aplikasi sedang stabil dan tidak ada masalah yang terkait versi saat ini
- perubahan hanya berupa version bump tanpa manfaat nyata
- upgrade menyentuh area generated code atau state management yang luas
- tim sedang mendekati cut release

## Level Verifikasi

Untuk upgrade kecil:

- `flutter analyze`
- targeted tests untuk fitur yang terdampak

Untuk upgrade besar:

- `flutter analyze`
- `flutter test` yang lebih luas atau full run
- QA manual untuk flow kritis:
  - login
  - scan QR
  - check-in
  - visit
  - check-out
  - reports
  - session expiry
  - flow permission yang terdampak

## Aturan Commit dan PR

- Satu concern upgrade per commit atau PR.
- Jangan campur upgrade dependency dengan feature atau refactor yang tidak terkait.
- Tulis alasan upgrade secara jelas:
  - bug fix
  - compatibility
  - security
  - maintenance

## Rekomendasi Saat Ini

- Pertahankan Flutter pada versi stable yang sekarang dipakai sampai ada alasan
  konkret untuk pindah.
- Upgrade package hanya jika memang menyelesaikan masalah nyata.
- Hindari upgrade major dependency kecuali tim siap menerima refactor dan
  regression testing tambahan.
