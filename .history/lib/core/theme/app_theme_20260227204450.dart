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
    ),
    scaffoldBackgroundColor: null,
  );
}
