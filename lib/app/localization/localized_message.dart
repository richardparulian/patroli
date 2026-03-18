import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/l10n/app_localizations_delegate.dart';
import 'package:patroli/l10n/l10n.dart';

const Map<String, String> _messageToKey = {
  'Lampu banner wajib dipilih': 'visit_error_lights_required',
  'Banner utama wajib dipilih': 'visit_error_banner_required',
  'Rolling door wajib dipilih': 'visit_error_rolling_door_required',
  'Semua checklist harus dicentang': 'visit_error_checklist_required',
  'Kondisi kanan wajib dipilih': 'visit_error_right_required',
  'Kondisi kiri wajib dipilih': 'visit_error_left_required',
  'Kondisi belakang wajib dipilih': 'visit_error_back_required',
  'Kondisi sekitar wajib dipilih': 'visit_error_around_required',
  'Status lampu wajib diisi!': 'visit_error_lights_required_fill',
  'Status banner wajib diisi!': 'visit_error_banner_required_fill',
  'Status rolling door wajib diisi!': 'visit_error_rolling_door_required_fill',
  'Kondisi kanan wajib diisi!': 'visit_error_right_required_fill',
  'Kondisi kiri wajib diisi!': 'visit_error_left_required_fill',
  'Kondisi belakang wajib diisi!': 'visit_error_back_required_fill',
  'Kondisi sekitar wajib diisi!': 'visit_error_around_required_fill',
  'Validation error!': 'validation_error',
  'Maaf, cabang dan foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan': 'branch_and_selfie_missing',
  'Maaf, cabang tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan': 'branch_missing_help',
  'Maaf, foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan': 'selfie_missing_help',
  'QR Code tidak boleh kosong': 'qr_code_required',
  'Kode QR tidak valid': 'qr_code_invalid',
  'Filename tidak boleh kosong': 'filename_required',
  'URL tidak boleh kosong': 'url_required',
  'User not found': 'user_not_found',
  'User tidak ditemukan': 'user_not_found',
  'Respon tidak ditemukan': 'response_not_found',
  'Response not found': 'response_not_found',
  'Gagal membaca gambar': 'image_read_failed',
  'Failed to read image': 'image_read_failed',
  'Presigned URL tidak ditemukan': 'presigned_url_not_found',
  'Presigned URL not found': 'presigned_url_not_found',
  'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong': 'login_credentials_required',
  'Waktu koneksi habis': 'network_timeout',
  'Permintaan dibatalkan': 'request_cancelled',
  'Tidak ada koneksi internet': 'no_internet_connection',
  'Terjadi error tidak diketahui': 'unknown_error',
  'Permintaan tidak valid': 'invalid_request',
  'Unauthorized - Silakan login kembali': 'unauthorized_relogin',
  'Forbidden - Anda tidak memiliki izin': 'forbidden_access',
  'Sumber daya tidak ditemukan': 'resource_not_found',
  'Validasi gagal': 'validation_failed',
  'Terlalu banyak permintaan - Silakan coba lagi nanti': 'too_many_requests',
  'Server error - Silakan coba lagi nanti': 'server_try_again',
  'Format data tidak valid': 'invalid_data_format',
  'No internet connection': 'no_internet_connection',
  'Server error occurred': 'server_try_again',
  'Connection timeout': 'network_timeout',
  'Cache failure': 'cache_failure',
  'Validation error': 'validation_error',
  'Authentication failed': 'authentication_failed',
  'Unauthorized access': 'unauthorized_access',
};

const Map<String, String> _messagePrefixToKey = {
  'Failed to write secure data:': 'secure_write_failed',
  'Failed to read secure data:': 'secure_read_failed',
  'Failed to delete secure data:': 'secure_delete_failed',
  'Failed to delete all secure data:': 'secure_delete_all_failed',
  'Failed to check secure key:': 'secure_check_key_failed',
  'Failed to read all secure data:': 'secure_read_all_failed',
  'Failed to save data:': 'local_save_failed',
  'Failed to retrieve data:': 'local_retrieve_failed',
  'Failed to check key:': 'local_check_key_failed',
  'Failed to remove data:': 'local_remove_failed',
  'Failed to clear data:': 'local_clear_failed',
};

String _translate(Ref ref, String key) {
  final translations = ref.read(translationsProvider);
  return translations[key] ?? localizedValues['en']?[key] ?? key;
}

String localizeMessage(Ref ref, String message) {
  final exactKey = _messageToKey[message];
  if (exactKey != null) return _translate(ref, exactKey);

  for (final entry in _messagePrefixToKey.entries) {
    if (message.startsWith(entry.key)) {
      return _translate(ref, entry.value);
    }
  }

  return message;
}

String localizeKey(Ref ref, String key) {
  return _translate(ref, key);
}
