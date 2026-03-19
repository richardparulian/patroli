import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'app_localizations_delegate.dart';

/// Main class for handling localizations in the app
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('id'), // Indonesian
  ];

  static bool isSupported(Locale locale) {
    return supportedLocales.contains(Locale(locale.languageCode));
  }

  /// Get a localized string by key
  String translate(String key) {
    final languageMap = localizedValues[locale.languageCode];
    if (languageMap == null) {
      return localizedValues['en']?[key] ?? key;
    }
    return languageMap[key] ?? localizedValues['en']?[key] ?? key;
  }

  /// Get a localized string with parameter substitution
  String translateWithParams(String key, Map<String, String> params) {
    String value = translate(key);
    params.forEach((paramKey, paramValue) {
      value = value.replaceAll('{$paramKey}', paramValue);
    });
    return value;
  }

  // Format methods for various data types

  /// Format currency with the current locale
  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: locale.toString(),
      symbol: getCurrencySymbol(),
    ).format(amount);
  }

  /// Format date with the current locale
  String formatDate(DateTime date) {
    return DateFormat.yMMMd(locale.toString()).format(date);
  }

  /// Format time with the current locale
  String formatTime(DateTime time) {
    return DateFormat.Hm(locale.toString()).format(time);
  }

  /// Get appropriate currency symbol based on locale
  String getCurrencySymbol() {
    switch (locale.languageCode) {
      case 'id':
        return 'Rp';
      case 'es':
        return '€';
      case 'ja':
        return '¥';
      case 'bn':
        return '৳';
      default:
        return '\$';
    }
  }
}

// Simple translations map - shared between classes
final Map<String, Map<String, String>> localizedValues = {
  'en': {
    'app_title': 'Flutter Riverpod Clean Architecture',
    'welcome_message': 'Welcome to Flutter Riverpod Clean Architecture',
    'home': 'Home',
    'settings': 'Settings',
    'profile': 'Profile',
    'dark_mode': 'Dark Mode',
    'light_mode': 'Light Mode',
    'system_mode': 'System Mode',
    'language': 'Language',
    'version': 'Version',
    'build_number': 'Build Number',
    'logout': 'Logout',
    'login': 'Login',
    'email': 'Email',
    'password': 'Password',
    'sign_in': 'Sign In',
    'register': 'Register',
    'forgot_password': 'Forgot Password?',
    'error_occurred': 'An error occurred',
    'try_again': 'Try Again',
    'cancel': 'Cancel',
    'save': 'Save',
    'delete': 'Delete',
    'edit': 'Edit',
    'no_data': 'No data available',
    'loading': 'Loading...',
    'on': 'On',
    'off': 'Off',
    'good': 'Good',
    'damaged': 'Damaged',
    'cache_expired': 'Cache has expired',
    'cache_updated': 'Cache updated successfully',
    'security_patrol_system': 'Security Patrol System',
    'branch_control_reporting': 'Branch condition control and reporting',
    'hello_user': 'Hello, {name}',
    'add_report': 'Add Report',
    'create_patrol_report': 'Create a patrol report',
    'report_list': 'Report List',
    'view_created_reports': 'View reports that have been created',
    'settings_subtitle': 'Manage language and app preferences',
    'language_tooltip': 'Language',
    'security_patrol': 'Security Patrol',
    'login_subtitle': 'Sign in to manage and report branch conditions',
    'employee_number': 'Employee Number (NIK)',
    'enter_employee_number': 'Enter Employee Number (NIK)',
    'employee_number_required': 'Employee Number (NIK) is required!',
    'enter_password': 'Enter password',
    'password_required': 'Password is required!',
    'reports_title': 'Report List',
    'no_reports': 'No reports yet',
    'start_first_report': 'Start patrol and create your first report',
    'report_detail': 'Report Detail',
    'continue': 'Continue',
    'check_in_label': 'Check In',
    'check_out_label': 'Check Out',
    'lights_status': 'Lights Status',
    'banner_status': 'Banner Status',
    'right_condition': 'Right Condition',
    'left_condition': 'Left Condition',
    'back_condition': 'Back Condition',
    'surrounding_condition': 'Surrounding Condition',
    'rolling_door_status': 'Rolling Door Status',
    'notes': 'Notes',
    'completed': 'Completed',
    'pending': 'Pending',
    'pending_reports': 'Pending Reports',
    'total_reports': 'Total Reports',
    'failed': 'Failed',
    'branch_data_not_found': 'Branch data not found',
    'back_to_home': 'Back to Home',
    'success': 'Success',
    'check_out_success_message':
        'Check-out successful, please review it again on the report list page',
    'view_reports': 'View Reports',
    'confirmation': 'Confirmation',
    'leave_page_confirmation': 'Are you sure you want to leave this page?',
    'check_out_confirmation_title': 'Check-Out Confirmation',
    'check_out_confirmation_subtitle':
        'Please take a selfie photo to confirm check-out',
    'branch': 'Branch',
    'processing_visit': 'Processing visit...',
    'check_in_photo': 'Check-In Photo',
    'check_out_photo': 'Check-Out Photo',
    'camera_preparing': 'Preparing camera...',
    'retake_photo': 'Retake Photo',
    'continue_action': 'Continue',
    'check_in_success_message':
        'Check-in confirmation successful, please continue to the next step',
    'check_in_confirmation_title': 'Check-In Confirmation',
    'check_in_confirmation_subtitle':
        'Please take a selfie photo to confirm the visit',
    'processing_selfie': 'Processing selfie photo...',
    'camera_permission_not_granted': 'Camera permission has not been granted.',
    'allow': 'Allow',
    'scan_qr_help_title': 'Having trouble scanning the QR code?',
    'scan_qr_help_message':
        'Please upload the QR code from the gallery or enter the branch code in the menu below.',
    'upload_from_gallery': 'Upload from gallery',
    'enter_branch_code': 'Enter branch code',
    'branch_code': 'Branch Code',
    'branch_code_hint': 'Enter a branch code, for example: KYB001-1',
    'ok': 'OK',
    'qr_not_found_in_image': 'QR code not found in image!',
    'processing_qr': 'Processing QR code...',
    'create_report': 'Create Report',
    'create_report_subtitle':
        'Please fill out the form below to create a report',
    'processing_fetch_data': 'Processing data retrieval...',
    'waiting_data': 'Waiting for data...',
    'attention': 'Attention!',
    'banner_lights': 'Banner Lights',
    'main_banner': 'Main Banner',
    'closed_tightly': 'Closed Tightly',
    'open_loose': 'Open/Loose',
    'flashlight_checked':
        'I have illuminated the rolling door using a flashlight',
    'knock_checked': 'I have performed the rolling door knocking step',
    'branch_condition_right': 'Branch Condition (Right)',
    'branch_condition_left': 'Branch Condition (Left)',
    'branch_condition_back': 'Branch Condition (Back)',
    'branch_condition_around': 'Branch Condition (Around)',
    'safe': 'Safe',
    'taruna': 'Guarded',
    'empty_shop': 'Empty Shop',
    'quiet': 'Quiet',
    'crowded': 'Crowded',
    'optional_notes': 'Notes (Optional)',
    'send': 'Send',
    'visit_success_message':
        'Report submitted successfully, please continue to the next step',
    'submit_report_confirmation':
        'Are you sure you want to submit this report?',
    'data_load_failed': 'Failed to load data',
    'image_detail': 'Image Detail',
    'yes': 'Yes',
    'delete_item_title': 'Delete {itemName}?',
    'delete_item_message':
        'Are you sure you want to delete this {itemName}? This action cannot be undone.',
    'logout_confirmation_title': 'Log out?',
    'logout_confirmation_message':
        'Are you sure you want to exit the application?',
    'session_expired_title': 'Session Expired',
    'session_expired_message': 'Your session has ended. Please sign in again.',
    'update_required_title': 'Required Update',
    'update_available_title': 'Update Available',
    'update_required_message':
        'A critical update (version {version}) is required to continue using this app.',
    'update_available_message': 'A new version ({version}) is available.',
    'update_whats_new': 'What\'s new:',
    'update_now': 'Update Now',
    'update_action': 'Update',
    'later': 'Later',
    'visit_error_lights_required': 'Banner lights must be selected',
    'visit_error_banner_required': 'Main banner must be selected',
    'visit_error_rolling_door_required': 'Rolling door must be selected',
    'visit_error_checklist_required': 'All checklist items must be checked',
    'visit_error_right_required': 'Right condition must be selected',
    'visit_error_left_required': 'Left condition must be selected',
    'visit_error_back_required': 'Back condition must be selected',
    'visit_error_around_required': 'Surrounding condition must be selected',
    'visit_error_lights_required_fill': 'Lights status is required!',
    'visit_error_banner_required_fill': 'Banner status is required!',
    'visit_error_rolling_door_required_fill':
        'Rolling door status is required!',
    'visit_error_right_required_fill': 'Right condition is required!',
    'visit_error_left_required_fill': 'Left condition is required!',
    'visit_error_back_required_fill': 'Back condition is required!',
    'visit_error_around_required_fill': 'Surrounding condition is required!',
    'validation_error': 'Validation error!',
    'branch_and_selfie_missing':
        'Branch and selfie photo were not found. Please try again or contact admin for help.',
    'branch_missing_help':
        'Branch was not found. Please try again or contact admin for help.',
    'selfie_missing_help':
        'Selfie photo was not found. Please try again or contact admin for help.',
    'qr_code_required': 'QR code is required',
    'qr_code_invalid': 'Invalid QR code',
    'filename_required': 'Filename is required',
    'url_required': 'URL is required',
    'user_not_found': 'User not found',
    'response_not_found': 'Response not found',
    'image_read_failed': 'Failed to read image',
    'presigned_url_not_found': 'Presigned URL not found',
    'login_credentials_required':
        'Employee Number (NIK) and password cannot be empty',
    'page_not_found': 'Page Not Found',
    'page_not_found_message': 'Page {path} was not found',
    'enjoying_app': 'Enjoying the app?',
    'share_feedback_prompt': 'Would you like to share your feedback with us?',
    'no_thanks': 'No thanks',
    'sure': 'Sure!',
    'feedback_matters': 'Your Feedback Matters',
    'feedback_request_message':
        'Please share your thoughts about the app. If you are enjoying it, a review on the app store would be greatly appreciated!',
    'enter_feedback_here': 'Enter your feedback here',
    'submit': 'Submit',
    'information': 'Information',
    'empty_shop_land': 'Empty Shop/Land',
    'network_timeout': 'Connection timeout',
    'request_cancelled': 'Request was cancelled',
    'no_internet_connection': 'No internet connection',
    'unknown_error': 'An unknown error occurred',
    'invalid_request': 'Invalid request',
    'unauthorized_relogin': 'Unauthorized. Please sign in again',
    'forbidden_access': 'You do not have permission to access this resource',
    'resource_not_found': 'Requested resource was not found',
    'validation_failed': 'Validation failed',
    'too_many_requests': 'Too many requests. Please try again later',
    'server_try_again': 'Server error. Please try again later',
    'invalid_data_format': 'Invalid data format',
    'cache_failure': 'Cache failure',
    'authentication_failed': 'Authentication failed',
    'unauthorized_access': 'Unauthorized access',
    'secure_write_failed': 'Failed to write secure data',
    'secure_read_failed': 'Failed to read secure data',
    'secure_delete_failed': 'Failed to delete secure data',
    'secure_delete_all_failed': 'Failed to delete all secure data',
    'secure_check_key_failed': 'Failed to check secure key',
    'secure_read_all_failed': 'Failed to read all secure data',
    'local_save_failed': 'Failed to save local data',
    'local_retrieve_failed': 'Failed to retrieve local data',
    'local_check_key_failed': 'Failed to check local key',
    'local_remove_failed': 'Failed to remove local data',
    'change_language': 'Change app language',
    'change_theme': 'Change app theme',
    'theme': 'Theme',
    'notifications': 'Notifications',
    'notification_settings': 'Notification settings',
    'language_settings': 'Language Settings',
    'current_language': 'Current Language',
    'language_code': 'Language Code',
    'language_name': 'Language Name',
    'localization_demo': 'Localization Demo',
    'localization_demo_description':
        'See language and region formatting examples',
    'localization_assets_demo': 'Localization Assets Demo',
    'localized_assets': 'Localized Assets',
    'localized_assets_explanation': 'Assets adapt to the selected language',
    'formatting_examples': 'Formatting Examples',
    'date_short': 'Short Date',
    'date_full': 'Full Date',
    'time': 'Time',
    'currency': 'Currency',
    'percent': 'Percent',
    'last_updated': 'Last updated',
    'welcome_message_label': 'Welcome message',
    'item_count_label': 'Item count',
    'image_example': 'Image Example',
    'common_image_example': 'Common image example',
    'common_image_caption': 'Common image shared across all languages',
    'welcome_image_caption': 'Welcome image based on the active language',
    'local_clear_failed': 'Failed to clear local data',
  },
  'id': {
    'app_title': 'Flutter Riverpod Arsitektur Bersih',
    'welcome_message': 'Selamat datang di Flutter Riverpod Arsitektur Bersih',
    'home': 'Beranda',
    'settings': 'Pengaturan',
    'profile': 'Profil',
    'dark_mode': 'Mode Gelap',
    'light_mode': 'Mode Terang',
    'system_mode': 'Mode Sistem',
    'language': 'Bahasa',
    'version': 'Versi',
    'build_number': 'Nomor Build',
    'logout': 'Keluar',
    'login': 'Masuk',
    'email': 'Email',
    'password': 'Kata Sandi',
    'sign_in': 'Masuk',
    'register': 'Daftar',
    'forgot_password': 'Lupa Kata Sandi?',
    'error_occurred': 'Terjadi kesalahan',
    'try_again': 'Coba Lagi',
    'cancel': 'Batal',
    'save': 'Simpan',
    'delete': 'Hapus',
    'edit': 'Ubah',
    'no_data': 'Tidak ada data',
    'loading': 'Memuat...',
    'on': 'Menyala',
    'off': 'Mati',
    'good': 'Bagus',
    'damaged': 'Rusak',
    'cache_expired': 'Cache telah kedaluwarsa',
    'cache_updated': 'Cache berhasil diperbarui',
    'change_language': 'Ubah bahasa aplikasi',
    'change_theme': 'Ubah tema aplikasi',
    'theme': 'Tema',
    'notifications': 'Notifikasi',
    'notification_settings': 'Pengaturan notifikasi',
    'language_settings': 'Pengaturan Bahasa',
    'current_language': 'Bahasa Saat Ini',
    'language_code': 'Kode Bahasa',
    'language_name': 'Nama Bahasa',
    'localization_demo': 'Demo Lokalisasi',
    'localization_demo_description': 'Lihat contoh format bahasa dan wilayah',
    'localization_assets_demo': 'Demo Aset Lokalisasi',
    'localized_assets': 'Aset Terlokalisasi',
    'localized_assets_explanation':
        'Aset akan menyesuaikan dengan bahasa yang dipilih',
    'formatting_examples': 'Contoh Format',
    'date_short': 'Tanggal Pendek',
    'date_full': 'Tanggal Lengkap',
    'time': 'Waktu',
    'currency': 'Mata Uang',
    'percent': 'Persentase',
    'last_updated': 'Terakhir diperbarui',
    'welcome_message_label': 'Selamat datang',
    'item_count_label': 'Jumlah item',
    'image_example': 'Contoh Gambar',
    'common_image_example': 'Contoh gambar umum',
    'common_image_caption': 'Gambar umum yang sama untuk semua bahasa',
    'welcome_image_caption': 'Gambar sambutan sesuai bahasa aktif',
    'security_patrol_system': 'Sistem Patroli Keamanan',
    'branch_control_reporting': 'Kontrol dan pelaporan kondisi cabang',
    'hello_user': 'Halo, {name}',
    'add_report': 'Tambah Laporan',
    'create_patrol_report': 'Buat laporan patroli',
    'report_list': 'Daftar Laporan',
    'view_created_reports': 'Lihat laporan yang telah dibuat',
    'settings_subtitle': 'Atur bahasa dan preferensi aplikasi',
    'language_tooltip': 'Bahasa',
    'security_patrol': 'Patroli Keamanan',
    'login_subtitle': 'Masuk untuk mengelola dan melaporkan kondisi cabang',
    'employee_number': 'Nomor Induk Karyawan (NIK)',
    'enter_employee_number': 'Masukkan Nomor Induk Karyawan (NIK)',
    'employee_number_required': 'Nomor Induk Karyawan (NIK) wajib diisi!',
    'enter_password': 'Masukkan kata sandi',
    'password_required': 'Kata Sandi wajib diisi!',
    'reports_title': 'Daftar Laporan',
    'no_reports': 'Belum ada laporan',
    'start_first_report': 'Mulai patroli dan buat laporan pertama Anda',
    'report_detail': 'Detail Laporan',
    'continue': 'Lanjutan',
    'check_in_label': 'Masuk',
    'check_out_label': 'Keluar',
    'lights_status': 'Status Lampu',
    'banner_status': 'Status Banner',
    'right_condition': 'Kondisi Kanan',
    'left_condition': 'Kondisi Kiri',
    'back_condition': 'Kondisi Belakang',
    'surrounding_condition': 'Kondisi Sekitar',
    'rolling_door_status': 'Status Rolling Door',
    'notes': 'Catatan',
    'completed': 'Selesai',
    'pending': 'Tertunda',
    'pending_reports': 'Laporan Tertunda',
    'total_reports': 'Total Laporan',
    'failed': 'Gagal',
    'branch_data_not_found': 'Data cabang tidak ditemukan',
    'back_to_home': 'Kembali ke Beranda',
    'success': 'Berhasil',
    'check_out_success_message':
        'Checkout berhasil, silahkan cek kembali di halaman daftar laporan',
    'view_reports': 'Lihat Laporan',
    'confirmation': 'Konfirmasi',
    'leave_page_confirmation':
        'Apakah Anda yakin ingin keluar dari halaman ini?',
    'check_out_confirmation_title': 'Konfirmasi Keluar',
    'check_out_confirmation_subtitle':
        'Silakan melakukan foto selfie untuk konfirmasi keluar',
    'branch': 'Cabang',
    'processing_visit': 'Memproses kunjungan...',
    'check_in_photo': 'Foto Masuk',
    'check_out_photo': 'Foto Keluar',
    'camera_preparing': 'Mempersiapkan kamera...',
    'retake_photo': 'Foto Ulang',
    'continue_action': 'Lanjutkan',
    'check_in_success_message':
        'Konfirmasi kunjungan berhasil, silahkan lanjut ke proses berikutnya',
    'check_in_confirmation_title': 'Konfirmasi Masuk',
    'check_in_confirmation_subtitle':
        'Silakan melakukan foto selfie untuk konfirmasi kunjungan',
    'processing_selfie': 'Memproses foto selfie...',
    'camera_permission_not_granted': 'Izin kamera belum diberikan.',
    'allow': 'Izinkan',
    'scan_qr_help_title': 'Kendala Scan Kode QR?',
    'scan_qr_help_message':
        'Silakan unggah kode QR dari galeri atau masukan kode cabang pada menu dibawah ini.',
    'upload_from_gallery': 'Unggah dari galeri',
    'enter_branch_code': 'Input kode cabang',
    'branch_code': 'Kode Cabang',
    'branch_code_hint': 'Masukkan kode cabang contoh: KYB001-1',
    'ok': 'Oke',
    'qr_not_found_in_image': 'Kode QR tidak ditemukan pada gambar!',
    'processing_qr': 'Memproses kode QR...',
    'create_report': 'Buat Laporan',
    'create_report_subtitle':
        'Silakan isi form dibawah ini untuk membuat laporan',
    'processing_fetch_data': 'Memproses pengambilan data...',
    'waiting_data': 'Menunggu data...',
    'attention': 'Perhatian!',
    'banner_lights': 'Lampu Banner',
    'main_banner': 'Banner Utama',
    'closed_tightly': 'Tertutup Rapat',
    'open_loose': 'Terbuka/Renggang',
    'flashlight_checked':
        'Saya sudah menyinari rolling door menggunakan senter',
    'knock_checked': 'Saya sudah melakukan tahap gedor rolling door',
    'branch_condition_right': 'Kondisi Cabang (Kanan)',
    'branch_condition_left': 'Kondisi Cabang (Kiri)',
    'branch_condition_back': 'Kondisi Cabang (Belakang)',
    'branch_condition_around': 'Kondisi Cabang (Sekitar)',
    'safe': 'Aman',
    'taruna': 'Taruna',
    'empty_shop': 'Ruko Kosong',
    'quiet': 'Sepi',
    'crowded': 'Ramai',
    'optional_notes': 'Catatan (Opsional)',
    'send': 'Kirim',
    'visit_success_message':
        'Laporan berhasil dikirim, silahkan lanjut ke proses berikutnya',
    'submit_report_confirmation':
        'Apakah Anda yakin ingin mengirim laporan ini?',
    'data_load_failed': 'Gagal Memuat Data',
    'image_detail': 'Foto Detail',
    'yes': 'Ya',
    'delete_item_title': 'Hapus {itemName}?',
    'delete_item_message':
        'Apakah Anda yakin ingin menghapus {itemName} ini? Tindakan ini tidak dapat dibatalkan.',
    'logout_confirmation_title': 'Keluar?',
    'logout_confirmation_message':
        'Apakah Anda yakin ingin keluar dari aplikasi?',
    'session_expired_title': 'Sesi Berakhir',
    'session_expired_message':
        'Sesi Anda telah berakhir. Silakan login kembali.',
    'visit_error_lights_required': 'Lampu banner wajib dipilih',
    'visit_error_banner_required': 'Banner utama wajib dipilih',
    'visit_error_rolling_door_required': 'Rolling door wajib dipilih',
    'visit_error_checklist_required': 'Semua checklist harus dicentang',
    'visit_error_right_required': 'Kondisi kanan wajib dipilih',
    'visit_error_left_required': 'Kondisi kiri wajib dipilih',
    'visit_error_back_required': 'Kondisi belakang wajib dipilih',
    'visit_error_around_required': 'Kondisi sekitar wajib dipilih',
    'visit_error_lights_required_fill': 'Status lampu wajib diisi!',
    'visit_error_banner_required_fill': 'Status banner wajib diisi!',
    'visit_error_rolling_door_required_fill':
        'Status rolling door wajib diisi!',
    'visit_error_right_required_fill': 'Kondisi kanan wajib diisi!',
    'visit_error_left_required_fill': 'Kondisi kiri wajib diisi!',
    'visit_error_back_required_fill': 'Kondisi belakang wajib diisi!',
    'visit_error_around_required_fill': 'Kondisi sekitar wajib diisi!',
    'validation_error': 'Validation error!',
    'branch_and_selfie_missing':
        'Maaf, cabang dan foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan',
    'branch_missing_help':
        'Maaf, cabang tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan',
    'selfie_missing_help':
        'Maaf, foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan',
    'qr_code_required': 'QR Code tidak boleh kosong',
    'qr_code_invalid': 'Kode QR tidak valid',
    'filename_required': 'Filename tidak boleh kosong',
    'url_required': 'URL tidak boleh kosong',
    'user_not_found': 'User tidak ditemukan',
    'response_not_found': 'Respon tidak ditemukan',
    'image_read_failed': 'Gagal membaca gambar',
    'presigned_url_not_found': 'Presigned URL tidak ditemukan',
    'login_credentials_required':
        'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong',
    'page_not_found': 'Halaman Tidak Ditemukan',
    'page_not_found_message': 'Halaman {path} tidak ditemukan',
    'update_required_title': 'Pembaruan Wajib',
    'update_available_title': 'Pembaruan Tersedia',
    'update_required_message':
        'Pembaruan penting (versi {version}) wajib dipasang untuk melanjutkan penggunaan aplikasi.',
    'update_available_message': 'Versi baru ({version}) tersedia.',
    'update_whats_new': 'Yang baru:',
    'update_now': 'Perbarui Sekarang',
    'update_action': 'Perbarui',
    'later': 'Nanti',
    'enjoying_app': 'Menikmati aplikasi ini?',
    'share_feedback_prompt':
        'Apakah Anda ingin membagikan masukan kepada kami?',
    'no_thanks': 'Tidak, terima kasih',
    'sure': 'Tentu!',
    'feedback_matters': 'Masukan Anda Berarti',
    'feedback_request_message':
        'Silakan bagikan pendapat Anda tentang aplikasi ini. Jika Anda menikmatinya, ulasan di app store akan sangat membantu.',
    'enter_feedback_here': 'Tulis masukan Anda di sini',
    'submit': 'Kirim',
    'information': 'Informasi',
    'empty_shop_land': 'Ruko/Lahan Kosong',
    'network_timeout': 'Waktu koneksi habis',
    'request_cancelled': 'Permintaan dibatalkan',
    'no_internet_connection': 'Tidak ada koneksi internet',
    'unknown_error': 'Terjadi error tidak diketahui',
    'invalid_request': 'Permintaan tidak valid',
    'unauthorized_relogin': 'Tidak diizinkan. Silakan login kembali',
    'forbidden_access':
        'Anda tidak memiliki izin untuk mengakses sumber daya ini',
    'resource_not_found': 'Sumber daya yang diminta tidak ditemukan',
    'validation_failed': 'Validasi gagal',
    'too_many_requests': 'Terlalu banyak permintaan. Silakan coba lagi nanti',
    'server_try_again': 'Terjadi kesalahan server. Silakan coba lagi nanti',
    'invalid_data_format': 'Format data tidak valid',
    'cache_failure': 'Terjadi kesalahan cache',
    'authentication_failed': 'Autentikasi gagal',
    'unauthorized_access': 'Akses tidak diizinkan',
    'secure_write_failed': 'Gagal menulis data aman',
    'secure_read_failed': 'Gagal membaca data aman',
    'secure_delete_failed': 'Gagal menghapus data aman',
    'secure_delete_all_failed': 'Gagal menghapus semua data aman',
    'secure_check_key_failed': 'Gagal memeriksa kunci data aman',
    'secure_read_all_failed': 'Gagal membaca semua data aman',
    'local_save_failed': 'Gagal menyimpan data lokal',
    'local_retrieve_failed': 'Gagal mengambil data lokal',
    'local_check_key_failed': 'Gagal memeriksa kunci data lokal',
    'local_remove_failed': 'Gagal menghapus data lokal',
    'local_clear_failed': 'Gagal membersihkan data lokal',
  },
  'es': {
    'app_title': 'Flutter Riverpod Arquitectura Limpia',
    'welcome_message': 'Bienvenido a Flutter Riverpod Arquitectura Limpia',
    'home': 'Inicio',
    'settings': 'Configuraciones',
    'profile': 'Perfil',
    'dark_mode': 'Modo Oscuro',
    'light_mode': 'Modo Claro',
    'system_mode': 'Modo Sistema',
    'language': 'Idioma',
    'logout': 'Cerrar Sesión',
    'login': 'Iniciar Sesión',
    'email': 'Correo Electrónico',
    'password': 'Contraseña',
    'sign_in': 'Iniciar Sesión',
    'register': 'Registrarse',
    'forgot_password': '¿Olvidó su Contraseña?',
    'error_occurred': 'Ocurrió un error',
    'try_again': 'Intentar de nuevo',
    'cancel': 'Cancelar',
    'save': 'Guardar',
    'delete': 'Eliminar',
    'edit': 'Editar',
    'no_data': 'No hay datos disponibles',
    'loading': 'Cargando...',
    'cache_expired': 'El caché ha expirado',
    'cache_updated': 'Caché actualizado con éxito',
  },
  'fr': {
    'app_title': 'Flutter Riverpod Architecture Propre',
    'welcome_message': 'Bienvenue à Flutter Riverpod Architecture Propre',
    // Add more French translations here
  },
  // Add translations for other supported languages
};

/// Extension on BuildContext for easier access to localization methods
extension LocalizationExtension on BuildContext {
  /// Get the AppLocalizations instance
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Translate a key to the current language
  String tr(String key) => l10n.translate(key);

  /// Translate a key with parameter substitution
  String trParams(String key, Map<String, String> params) =>
      l10n.translateWithParams(key, params);

  /// Format currency according to the current locale
  String currency(double amount) => l10n.formatCurrency(amount);

  /// Format date according to the current locale
  String formatDate(DateTime date) => l10n.formatDate(date);

  /// Format time according to the current locale
  String formatTime(DateTime time) => l10n.formatTime(time);
}
