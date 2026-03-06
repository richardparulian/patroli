import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toastification/toastification.dart';

/// Global service untuk menampilkan toast dengan style konsisten
/// Menggunakan plugin toastification untuk tampilan modern dan animasi yang smooth
enum ToastPosition {
  top,
  bottom,
}

/// Mendapatkan warna primary dari tema aplikasi
Color _getPrimaryColor(BuildContext context) {
  return Theme.of(context).colorScheme.surface;
}

class AppToast {
  /// Tampilkan pesan error dengan modern style
  static void showError({required BuildContext context, required String title, String? description, ToastPosition position = ToastPosition.top, Duration? duration, VoidCallback? onDismiss, bool showProgressBar = false}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      description: description != null ? Text(description,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: null,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Iconsax.info_circle5, color: Colors.red, size: 28),
      ),
      primaryColor: colorScheme.error,
      // backgroundColor: colorScheme.error.withValues(alpha: 0.5),
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
    required BuildContext context,
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    final primaryColor = _getPrimaryColor(context);
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
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

  /// Tampilkan pesan info dengan modern style
  static void showInfo({
    required BuildContext context,
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    final primaryColor = _getPrimaryColor(context);
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          color: Colors.white,
        ),
      ) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.info,
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

  /// Tampilkan pesan warning dengan modern style
  static void showWarning({
    required BuildContext context,
    required String title,
    String? description,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismiss,
    bool showProgressBar = true,
  }) {
    final primaryColor = _getPrimaryColor(context);
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: Text(title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          color: Colors.white,
        ),
      ) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: showProgressBar,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.warning,
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

  /// Tampilkan pesan dengan custom style
  static void showCustom({
    required BuildContext context,
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
      title: Text(title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: description != null ? Text(description,
        style: const TextStyle(
          color: Colors.white,
        ),
      ) : null,
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
        return const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 16);
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
    required BuildContext context,
    required String title,
    String? description,
    required ToastificationType type,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    final primaryColor = _getPrimaryColor(context);
    toastification.show(
      type: type,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: _getAlignment(position),
      autoCloseDuration: duration,
      showProgressBar: false,
      animationDuration: const Duration(milliseconds: 300),
      primaryColor: primaryColor,
      padding: const EdgeInsets.all(12),
      margin: _getMargin(position),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
