import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart' as local_auth;
import 'package:local_auth_android/local_auth_android.dart'
    show AndroidAuthMessages, AuthMessages;
import 'package:local_auth_darwin/local_auth_darwin.dart'
    show IOSAuthMessages;
import 'package:patroli/core/auth/biometric_service.dart';

class LocalBiometricService implements BiometricService {
  final local_auth.LocalAuthentication _localAuth =
      local_auth.LocalAuthentication();

  BiometricType _mapBiometricType(local_auth.BiometricType type) {
    switch (type) {
      case local_auth.BiometricType.fingerprint:
        return BiometricType.fingerprint;
      case local_auth.BiometricType.face:
        return BiometricType.face;
      case local_auth.BiometricType.iris:
        return BiometricType.iris;
      default:
        return BiometricType.multiple;
    }
  }

  @override
  Future<bool> isAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics &&
          await _localAuth.isDeviceSupported();
    } on PlatformException catch (e) {
      debugPrint('Error checking biometric availability: ${e.message}');
      return false;
    }
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.map(_mapBiometricType).toList();
    } on PlatformException catch (e) {
      debugPrint('Error getting available biometrics: ${e.message}');
      return [];
    }
  }

  @override
  Future<BiometricResult> authenticate({
    required String localizedReason,
    AuthReason reason = AuthReason.appAccess,
    bool sensitiveTransaction = false,
    String? dialogTitle,
    String? cancelButtonText,
  }) async {
    final isAvailable = await this.isAvailable();
    if (!isAvailable) {
      return BiometricResult.notAvailable;
    }

    final biometrics = await getAvailableBiometrics();
    if (biometrics.isEmpty) {
      return BiometricResult.notEnrolled;
    }

    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: true,
        sensitiveTransaction: sensitiveTransaction,
        persistAcrossBackgrounding: true,
        authMessages: <AuthMessages>[
          IOSAuthMessages(
            cancelButton: cancelButtonText ?? 'Cancel',
            localizedFallbackTitle: dialogTitle,
          ),
          AndroidAuthMessages(
            cancelButton: cancelButtonText ?? 'Cancel',
            signInTitle: dialogTitle ?? localizedReason,
          ),
        ],
      );

      return didAuthenticate ? BiometricResult.success : BiometricResult.failed;
    } on local_auth.LocalAuthException catch (e) {
      debugPrint(
        'Biometric authentication error: ${e.description}, code: ${e.code}',
      );
      return _mapExceptionCodeToResult(e.code);
    } on PlatformException catch (e) {
      debugPrint(
        'Biometric authentication platform error: ${e.message}, code: ${e.code}',
      );
      return _mapPlatformCodeToResult(e.code);
    } catch (e) {
      debugPrint('Unexpected biometric error: $e');
      return BiometricResult.error;
    }
  }

  BiometricResult _mapExceptionCodeToResult(
    local_auth.LocalAuthExceptionCode code,
  ) {
    switch (code) {
      case local_auth.LocalAuthExceptionCode.noBiometricHardware:
      case local_auth.LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable:
      case local_auth.LocalAuthExceptionCode.uiUnavailable:
        return BiometricResult.notAvailable;
      case local_auth.LocalAuthExceptionCode.noBiometricsEnrolled:
      case local_auth.LocalAuthExceptionCode.noCredentialsSet:
        return BiometricResult.notEnrolled;
      case local_auth.LocalAuthExceptionCode.biometricLockout:
      case local_auth.LocalAuthExceptionCode.temporaryLockout:
        return BiometricResult.lockedOut;
      case local_auth.LocalAuthExceptionCode.userCanceled:
      case local_auth.LocalAuthExceptionCode.systemCanceled:
      case local_auth.LocalAuthExceptionCode.userRequestedFallback:
      case local_auth.LocalAuthExceptionCode.timeout:
        return BiometricResult.cancelled;
      default:
        return BiometricResult.error;
    }
  }

  BiometricResult _mapPlatformCodeToResult(String code) {
    switch (code) {
      case 'NotAvailable':
      case 'NotSupported':
      case 'no_biometric_hardware':
      case 'biometricUnavailable':
        return BiometricResult.notAvailable;
      case 'NotEnrolled':
      case 'PasscodeNotSet':
      case 'no_biometrics_enrolled':
        return BiometricResult.notEnrolled;
      case 'LockedOut':
      case 'PermanentlyLockedOut':
      case 'temporaryLockout':
      case 'biometricLockout':
        return BiometricResult.lockedOut;
      case 'UserCancel':
      case 'SystemCancel':
      case 'AppCancel':
      case 'userCanceled':
      case 'systemCanceled':
        return BiometricResult.cancelled;
      default:
        return BiometricResult.error;
    }
  }
}
