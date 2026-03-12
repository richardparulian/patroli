import 'package:flutter/material.dart';
import 'package:pos/core/constants/app_constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppConstants.primaryColor,
      onPrimary: Colors.white,
      error: const Color(0xFFD32F2F),        
      onError: Colors.white,
      secondary: const Color(0xFF6366F1),    
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: null,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppConstants.primaryColor,
      onPrimary: Colors.white,
      error: const Color(0xFFFF5252),
      onError: Colors.black,
      secondary: const Color(0xFF818CF8),
      surface: const Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: null,
  );
}
