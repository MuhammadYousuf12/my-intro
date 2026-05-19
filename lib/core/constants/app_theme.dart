import 'package:flutter/material.dart';
import 'app_colors.dart';

// App theme - modern dark and light with consistent card styling
class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF22C55E),
      surface: AppColors.darkSurface,
    ),
    cardColor: AppColors.darkCard,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF22C55E),
      surface: AppColors.lightSurface,
    ),
    cardColor: AppColors.lightSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
    ),
  );
}
