import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos/core/accessibility/accessibility_providers.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/providers/localization_providers.dart';
import 'package:pos/core/providers/storage_providers.dart';
import 'package:pos/core/router/app_router.dart';
import 'package:pos/core/theme/app_theme.dart';
import 'package:pos/core/updates/update_providers.dart';
import 'package:pos/config/app_config.dart';
import 'package:pos/l10n/app_localizations_delegate.dart';
import 'package:pos/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

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

  // Run the app with ProviderScope to enable Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override the shared preferences provider with the instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override the default locale provider to use our persistent locale
        defaultLocaleProvider.overrideWith(
          (ref) => ref.watch(persistentLocaleProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Provider to manage theme mode
// Provider to manage theme mode
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void set(ThemeMode mode) => state = mode;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router from provider
    final router = ref.watch(routerProvider);

    // Watch the theme mode
    final themeMode = ref.watch(themeModeProvider);

    // Watch the persistent locale
    final locale = ref.watch(persistentLocaleProvider);

    return UpdateChecker(
      autoPrompt: true,
      enforceCriticalUpdates: true,
      child: AccessibilityWrapper(
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return UpdateChecker(
              autoPrompt: true,
              enforceCriticalUpdates: true,
              child: child!,
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
      ),
    );
  }
}
