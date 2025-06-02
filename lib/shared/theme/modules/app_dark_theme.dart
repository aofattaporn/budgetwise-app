import 'dart:ui';

import 'package:budget_wise/shared/theme/app_theme.dart';
import 'package:budget_wise/shared/theme/system/app_colors.dart';
import 'package:budget_wise/shared/theme/system/app_radaius.dart';
import 'package:flutter/material.dart';

class AppDarkTheme {
  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color.fromARGB(255, 40, 41, 65)),
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    cardColor: AppColors.grayDark800,
    canvasColor: AppColors.grayDark800,
    dividerColor: AppColors.grayDark300,
    textTheme: AppTheme.textTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    elevatedButtonTheme: AppTheme.elevatedButtonTheme,
    outlinedButtonTheme: AppTheme.outlinedButtonTheme,
    inputDecorationTheme: AppTheme.inputDecorationTheme.copyWith(
      fillColor: AppColors.grayDark700,
      hintStyle: const TextStyle(color: AppColors.grayDark300),
      labelStyle: const TextStyle(color: AppColors.grayDark100),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grayDark500),
        borderRadius: BorderRadius.circular(AppRadius.sm.x),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(AppRadius.sm.x),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );
}
