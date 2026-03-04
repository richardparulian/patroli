import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos/core/accessibility/accessibility_providers.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/providers/localization_providers.dart';
import 'package:pos/core/providers/storage_providers.dart';
import 'package:pos/core/providers/theme_providers.dart';
import 'package:pos/core/router/app_router.dart';
import 'package:pos/core/theme/app_theme.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/core/updates/update_providers.dart';
import 'package:pos/config/app_config.dart';
import 'package:pos/l10n/app_localizations_delegate.dart';
import 'package:pos/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras
  cameras = await availableCameras();

  // Load environment variables
  try {
    await dotenv.load(fileName: 'lib/config/environment/.env');
  } catch (e) {
    // If .env file not found, continue with default values
    debugPrint('Warning: Could not load .env file: $e');
  }

  // Set environment based on loaded env variable
  final envName = dotenv.env['ENV'] ?? 'dev';
  AppConfig.setEnvironment(AppConfig.parseEnvironment(envName));

  // Print environment info (in debug mode only)
  if (AppConfig.isDebugEnabled) {
    debugPrint('=== App Environment ===');
    debugPrint('Environment: ${AppConfig.environmentName}');
    debugPrint('API Base URL: ${AppConfig.apiBaseUrl}');
    debugPrint('App Name: ${AppConfig.appName}');
    debugPrint('Debug Mode: ${AppConfig.isDebugEnabled}');
    debugPrint('Logging Enabled: ${AppConfig.isLoggingEnabled}');
    debugPrint('========================');
  }

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Run app with ProviderScope to enable Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override with shared preferences provider with instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override default locale provider to use our persistent locale
        defaultLocaleProvider.overrideWith((ref) => ref.watch(persistentLocaleProvider)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch: router from provider
    final router = ref.watch(routerProvider);

    // Watch: theme mode
    final themeMode = ref.watch(themeModeProvider);

    // Watch: persistent locale
    final locale = ref.watch(persistentLocaleProvider);

    return AccessibilityWrapper(
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // Lock text scale factor to 1.0 (prevents system font scale)
          final mediaQuery = MediaQuery.of(context);
          
          // Initialize ScreenUtil once
          ScreenUtil.init(context);
          
          final viewInsets = mediaQuery.viewInsets;
          final viewPadding = mediaQuery.viewPadding;
          final bottomPadding = Platform.isAndroid ? (viewInsets.bottom > 0 ? 0.0 : viewPadding.bottom) : 0.0;
          
          // Lock font size by overriding textScaler
          final lockedMediaQuery = mediaQuery.copyWith(
            textScaler: TextScaler.linear(1.0),
          );
          
          return MediaQuery(
            data: lockedMediaQuery,
            child: UpdateChecker(
              autoPrompt: true,
              enforceCriticalUpdates: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          );
        },

        // Localization settings
        locale: locale,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
