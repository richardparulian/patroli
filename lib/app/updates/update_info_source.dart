import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/constants/app_metadata.dart';
import 'package:patroli/config/app_config.dart';
import 'package:patroli/core/updates/update_service.dart';

abstract class AppUpdateInfoSource {
  Future<UpdateInfo?> getUpdateInfo(String currentVersion);
}

class ConfiguredAppUpdateInfoSource implements AppUpdateInfoSource {
  const ConfiguredAppUpdateInfoSource();

  @override
  Future<UpdateInfo?> getUpdateInfo(String currentVersion) async {
    final updateUrl = _resolveUpdateUrl();
    final appcastUrl = AppMetadata.appcastUrl.trim();

    final hasPlaceholderAppcast = !AppMetadata.hasConfiguredAppcastUrl;
    if (hasPlaceholderAppcast && updateUrl == null) {
      return null;
    }

    final environmentName = AppConfig.environmentName.toLowerCase();
    final minimumRequiredVersion = currentVersion;

    return UpdateInfo(
      latestVersion: currentVersion,
      minimumRequiredVersion: minimumRequiredVersion,
      isCritical: false,
      releaseNotes:
          'Update source configured for $environmentName environment.',
      updateUrl: updateUrl ?? (hasPlaceholderAppcast ? null : appcastUrl),
    );
  }

  String? _resolveUpdateUrl() {
    if (Platform.isAndroid) {
      if (!AppMetadata.hasPackageName) return null;
      return 'https://play.google.com/store/apps/details?id=${AppMetadata.packageName}';
    }
    if (Platform.isIOS) {
      if (!AppMetadata.hasIOSAppId) return null;
      return 'https://apps.apple.com/app/id${AppMetadata.iOSAppId}';
    }
    return null;
  }
}

final appUpdateInfoSourceProvider = Provider<AppUpdateInfoSource>((ref) {
  return const ConfiguredAppUpdateInfoSource();
});
