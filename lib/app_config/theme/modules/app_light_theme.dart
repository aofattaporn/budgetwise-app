import 'dart:ui';

import 'package:budget_wise/app_config/theme/app_theme.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/app_config/theme/system/app_radaius.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.gray200,
    cardColor: AppColors.white,
    canvasColor: AppColors.surface,
    dividerColor: AppColors.gray300,
    textTheme: AppTheme.textTheme,
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.background),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
    inputDecorationTheme: AppTheme.inputDecorationTheme.copyWith(
      fillColor: AppColors.white,
      hintStyle: const TextStyle(color: AppColors.gray500),
      labelStyle: const TextStyle(color: AppColors.gray700),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.gray300),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm.x)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm.x)),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    elevatedButtonTheme: AppTheme.elevatedButtonTheme,
    outlinedButtonTheme: AppTheme.outlinedButtonTheme,
    cardTheme: AppTheme.cardTheme,
    hoverColor: AppColors.gray200,
    highlightColor: AppColors.primary.withOpacity(0.1),
  );
}
