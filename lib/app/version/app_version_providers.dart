import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionInfo {
  const AppVersionInfo({required this.version, required this.buildNumber});

  static const fallback = AppVersionInfo(version: '1.0.0', buildNumber: '1');

  final String version;
  final String buildNumber;

  String get shortLabel => 'v$version ($buildNumber)';
  String get fullLabel => '$version+$buildNumber';
}

final appVersionInfoProvider = FutureProvider<AppVersionInfo>((ref) async {
  final packageInfo = await PackageInfo.fromPlatform();
  return AppVersionInfo(
    version: packageInfo.version,
    buildNumber: packageInfo.buildNumber,
  );
});
