import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF134284);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ).copyWith(
          primary: _seedColor,
          onPrimary: Colors.white,
          error: const Color(0xFFD32F2F),
          onError: Colors.white,
          secondary: const Color(0xFF6366F1),
          surface: Colors.white,
        ),
    scaffoldBackgroundColor: null,
    appBarTheme: AppBarTheme(centerTitle: false),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ).copyWith(
          primary: _seedColor,
          onPrimary: Colors.white,
          error: const Color(0xFFFF5252),
          onError: Colors.black,
          secondary: const Color(0xFF818CF8),
          surface: const Color(0xFF1E1E1E),
        ),
    scaffoldBackgroundColor: null,
    appBarTheme: AppBarTheme(centerTitle: false),
  );
}
