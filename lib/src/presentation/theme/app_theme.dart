import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/system/app_radaius.dart';
import 'package:budget_wise/src/presentation/theme/system/app_text_style.dart';
import 'package:flutter/material.dart';
import 'system/app_spacing.dart';

class AppTheme {
  AppTheme._();

  /// Text Theme (Common for both light and dark modes)
  static const TextTheme textTheme = TextTheme(
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
  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
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
  static final OutlinedButtonThemeData outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
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
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: AppColors.gray300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: AppColors.gray300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    filled: true,
    fillColor: AppColors.white,
    hintStyle: const TextStyle(color: AppColors.gray500),
    labelStyle: const TextStyle(color: AppColors.gray700),
  );

  /// Card Theme
  static final CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm.x),
    ),
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.1),
  );
}
