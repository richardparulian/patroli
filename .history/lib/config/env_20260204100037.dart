import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/config/environment/.env')
abstract class Env {
  @EnviedField(varName: 'ENV', defaultValue: 'dev')
  static const String env = _Env.env;

  @EnviedField(varName: 'APP_NAME', defaultValue: 'Flutter POS')
  static const String appName = _Env.appName;

  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'https://api.yourdomain.com')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_TIMEOUT', defaultValue: 30000)
  static const int apiTimeout = _Env.apiTimeout;

  @EnviedField(varName: 'ENABLE_DEBUG', defaultValue: true)
  static const bool enableDebug = _Env.enableDebug;

  @EnviedField(varName: 'ENABLE_LOGGING', defaultValue: true)
  static const bool enableLogging = _Env.enableLogging;
}
