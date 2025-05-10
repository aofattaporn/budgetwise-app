import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_radaius.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'app_spacing.dart';

/// {@template app_theme}
/// Centralized theme class for the app.
/// {@endtemplate}
class AppTheme {
  AppTheme._();

  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue, // Define your main color
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    cardTheme: _cardTheme,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primary,
    primaryColorDark: AppColors.primary,
    scaffoldBackgroundColor: AppColors.grayDark.shade100,
  );

  /// Dark Theme
  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.grayDark.shade900,
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLigth,
    cardColor: AppColors.grayDark.shade800,
    canvasColor: AppColors.grayDark.shade900,
    dividerColor: AppColors.grayDark.shade600,
    textTheme: _textTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.grayDark.shade800,
      foregroundColor: AppColors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.white),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme.copyWith(
      fillColor: AppColors.grayDark.shade700,
      hintStyle: const TextStyle(color: AppColors.grayLight),
      labelStyle: const TextStyle(color: AppColors.grayLight),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grayDark.shade600),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );

  /// Text Theme (Common for both light and dark modes)
  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  /// Elevated Button Theme
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm.x),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    ),
  );

  /// Outlined Button Theme
  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blue,
      side: const BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm.x),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    ),
  );

  /// Input Decoration Theme
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    filled: true,
    fillColor: Colors.white,
  );

  /// Card Theme
  static final CardTheme _cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
    ),
    elevation: 2,
    // ignore: deprecated_member_use
    shadowColor: Colors.black.withOpacity(0.1),
  );
}
