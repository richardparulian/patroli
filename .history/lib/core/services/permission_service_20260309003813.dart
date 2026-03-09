import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';

class PermissionService {
  // :: Check if a specific permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // :: Check and request a single permission
  // :: Returns true if permission is granted, false otherwise
  static Future<bool> checkAndRequestPermission(
    Permission permission, {
    BuildContext? context,
    String? deniedTitle,
    String? deniedMessage,
    String? deniedButtonText,
    String? permanentlyDeniedTitle,
    String? permanentlyDeniedMessage,
    String? permanentlyDeniedButtonText,
    bool isCheckPermission = false,
  }) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied && context != null) {
      final title = permanentlyDeniedTitle ?? _getDefaultTitle(permission);
      final message = permanentlyDeniedMessage ?? _getDefaultPermanentlyDeniedMessage(permission);
      final buttonText = permanentlyDeniedButtonText ?? 'Izinkan';

      if (!context.mounted) return false;
      if (isCheckPermission) return false;

      AppDialog.showWarning(
        context: context,
        title: title,
        message: message,
        buttonText: buttonText,
        barrierDismissible: false,
        onButtonPressed: () async => await openAppSettings(),
      );
    }

    return false;
  }

  // :: Check and request camera permission with default messages
  static Future<bool> checkAndRequestCameraPermission({BuildContext? context, String? deniedMessage, String? permanentlyDeniedMessage, bool isCheckPermission = false}) async {
    return checkAndRequestPermission(
      Permission.camera,
      context: context,
      deniedMessage: deniedMessage ?? 'Izinkan akses ke kamera untuk mengambil foto',
      permanentlyDeniedMessage: permanentlyDeniedMessage ?? 'Izinkan akses ke kamera untuk mengambil foto',
      permanentlyDeniedTitle: 'Akses Kamera Ditolak',
      permanentlyDeniedButtonText: 'Izinkan',
      isCheckPermission: isCheckPermission,
    );
  }

  // :: Check and request location permission
  static Future<bool> checkAndRequestLocationPermission({BuildContext? context, String? deniedMessage, String? permanentlyDeniedMessage}) async {
    return checkAndRequestPermission(
      Permission.location,
      context: context,
      deniedMessage: deniedMessage ?? 'Izinkan akses ke lokasi untuk melanjutkan',
      permanentlyDeniedMessage: permanentlyDeniedMessage ?? 'Izinkan akses ke lokasi untuk melanjutkan',
      permanentlyDeniedTitle: 'Akses Lokasi Ditolak',
      permanentlyDeniedButtonText: 'Izinkan',
    );
  }

  // :: Check and request storage permission
  static Future<bool> checkAndRequestStoragePermission({BuildContext? context, String? deniedMessage, String? permanentlyDeniedMessage}) async {
    return checkAndRequestPermission(Permission.storage,
      context: context,
      deniedMessage: deniedMessage ?? 'Izinkan akses ke penyimpanan untuk menyimpan file',
      permanentlyDeniedMessage: permanentlyDeniedMessage ?? 'Izinkan akses ke penyimpanan untuk menyimpan file',
      permanentlyDeniedTitle: 'Akses Penyimpanan Ditolak',
      permanentlyDeniedButtonText: 'Izinkan',
    );
  }

  // :: Request multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return permissions.request();
  }

  // :: Open app settings for permission management
  static Future<void> openSettings() async {
    await openAppSettings();
  }

  static String _getDefaultTitle(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return 'Akses Kamera Ditolak';
      case Permission.location:
        return 'Akses Lokasi Ditolak';
      case Permission.storage:
        return 'Akses Penyimpanan Ditolak';
      case Permission.photos:
        return 'Akses Foto Ditolak';
      case Permission.microphone:
        return 'Akses Mikrofon Ditolak';
      default:
        return 'Akses Ditolak';
    }
  }

  static String _getDefaultPermanentlyDeniedMessage(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return 'Izinkan akses ke kamera untuk mengambil foto';
      case Permission.location:
        return 'Izinkan akses ke lokasi untuk melanjutkan';
      case Permission.storage:
        return 'Izinkan akses ke penyimpanan untuk menyimpan file';
      case Permission.photos:
        return 'Izinkan akses ke galeri untuk memilih foto';
      case Permission.microphone:
        return 'Izinkan akses ke mikrofon untuk merekam suara';
      default:
        return 'Izinkan akses yang diperlukan di pengaturan aplikasi';
    }
  }
}
