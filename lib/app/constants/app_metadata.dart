class AppMetadata {
  static const String appName = 'Patroli';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.pgi.patroli';
  static const String iOSAppId = '123456789';
  static const String appcastUrl = 'https://your-appcast-url.com/appcast.xml';

  static bool get hasPackageName =>
      packageName.trim().isNotEmpty && !packageName.contains('com.example');

  static bool get hasIOSAppId =>
      iOSAppId.trim().isNotEmpty && iOSAppId != '123456789';

  static bool get hasConfiguredAppcastUrl =>
      appcastUrl.trim().isNotEmpty &&
      !appcastUrl.contains('your-appcast-url.com');
}
