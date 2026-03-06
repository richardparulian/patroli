import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toastification/toastification.dart';

/// Global service untuk menampilkan toast dengan style konsisten
/// Menggunakan plugin toastification untuk tampilan modern dan animasi yang smooth
enum ToastPosition {
  top,
  bottom,
}

class AppToast {
  /// Tampilkan pesan error dengan modern style
  static void showError({required String title, String? description, ToastPosition position = ToastPosition.top, Duration duration = const Duration(seconds: 4), VoidCallback? onDismiss, bool showProgressBar = true}) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Iconsax.info_circle, color: Colors.white, size: 28),
      ),
      // primaryColor: Colors.red,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      pauseOnHover: true,
      dragToClose: true,
      closeOnClick: false,
      padding: const EdgeInsets.all(10),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Tampilkan pesan success dengan modern style
  static void showSuccess({
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      primaryColor: const Color(0xFF4CAF50),
      backgroundColor: const Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      pauseOnHover: true,
      dragToClose: true,
      closeOnClick: false,
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Tampilkan pesan info dengan modern style
  static void showInfo({
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      primaryColor: const Color(0xFF2196F3),
      backgroundColor: const Color(0xFF2196F3),
      foregroundColor: Colors.white,
      pauseOnHover: true,
      dragToClose: true,
      closeOnClick: false,
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Tampilkan pesan warning dengan modern style
  static void showWarning({
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.warning,
        color: Colors.white,
      ),
      primaryColor: const Color(0xFFFF9800),
      backgroundColor: const Color(0xFFFF9800),
      foregroundColor: Colors.white,
      pauseOnHover: true,
      dragToClose: true,
      closeOnClick: false,
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Tampilkan pesan dengan custom style
  static void showCustom({
    required String title,
    String? description,
    required Color primaryColor,
    required IconData icon,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
  }) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      primaryColor: primaryColor,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      pauseOnHover: true,
      dragToClose: true,
      closeOnClick: false,
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Method untuk mendapatkan alignment berdasarkan posisi
  static Alignment _getAlignment(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return Alignment.topCenter;
      case ToastPosition.bottom:
        return Alignment.bottomCenter;
    }
  }

  /// Method untuk mendapatkan margin berdasarkan posisi
  static EdgeInsets _getMargin(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 16);
      case ToastPosition.bottom:
        return const EdgeInsets.all(16);
    }
  }

  /// Dismiss semua toast
  static void dismissAll() {
    toastification.dismissAll();
  }

  /// Show toast minimal (simple style)
  static void showSimple({
    required String title,
    String? description,
    required ToastificationType type,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.show(
      type: type,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: false,
      animationDuration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
