import 'package:pos/config/env.dart';

/// Enum untuk Environment Type
enum Environment {
  dev,
  staging,
  prod,
}

/// Class untuk manajemen konfigurasi aplikasi
class AppConfig {
  static Environment _currentEnvironment = Environment.dev;

  /// Set environment saat ini
  static void setEnvironment(Environment env) {
    _currentEnvironment = env;
  }

  /// Get environment saat ini
  static Environment get currentEnvironment => _currentEnvironment;

  /// Get nama environment sebagai string
  static String get environmentName => Env.env;

  /// Check apakah dalam mode development
  static bool get isDevelopment => _currentEnvironment == Environment.dev;

  /// Check apakah dalam mode staging
  static bool get isStaging => _currentEnvironment == Environment.staging;

  /// Check apakah dalam mode production
  static bool get isProduction => _currentEnvironment == Environment.prod;

  /// Get API Base URL berdasarkan environment
  static String get apiBaseUrl => Env.apiBaseUrl;

  /// Get API Timeout
  static int get apiTimeout => Env.apiTimeout;

  /// Get App Name
  static String get appName => Env.appName;

  /// Check apakah debug mode diaktifkan
  static bool get isDebugEnabled => Env.enableDebug;

  /// Check apakah logging diaktifkan
  static bool get isLoggingEnabled => Env.enableLogging;

  /// Parse environment dari string
  static Environment parseEnvironment(String envString) {
    switch (envString.toLowerCase()) {
      case 'staging':
        return Environment.staging;
      case 'prod':
      case 'production':
        return Environment.prod;
      case 'dev':
      case 'development':
      default:
        return Environment.dev;
    }
  }
}
