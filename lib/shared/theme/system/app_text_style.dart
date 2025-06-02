import 'package:budget_wise/shared/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

/// {@template app_text_styles}
/// Class that contains all text styles used across the app.
/// {@endtemplate}
class AppTextStyles {
  AppTextStyles._();

  // ============================================================================
  // =                                  DISPLAY                                =
  // ============================================================================

  // ====> Dark Color
  static const displayLarge = TextStyle(
    color: AppColors.black,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static const displayMedium = TextStyle(
    color: AppColors.black,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const displaySmall = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // ====> PrimaryDark Color
  static const displayPrimaryLarge = TextStyle(
    color: AppColors.primaryDark,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static const displayPrimaryMedium = TextStyle(
    color: AppColors.primaryDark,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const displayPrimarySmall = TextStyle(
    color: AppColors.primaryDark,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // ============================================================================
  // =                                 HEADLINE                                =
  // ============================================================================

  static const headlineLarge = TextStyle(
    color: AppColors.black,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const headlineMedium = TextStyle(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const headlineSmall = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ============================================================================
  // =                                   BODY                                  =
  // ============================================================================

  static const bodyLarge = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    color: AppColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // ============================================================================
  // =                                   LABEL                                 =
  // ============================================================================

  static const labelLarge = TextStyle(
    color: AppColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const labelMedium = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const labelSmall = TextStyle(
    color: AppColors.black,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // ============================================================================
  // =                                 SPECIAL LABELS                          =
  // ============================================================================

  static const labelGraySmall = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const labelPrimarySmall = TextStyle(
    color: AppColors.primaryDark,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.4,
  );

  static const labelPrimarySubtleNormal = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primarySubtle,
  );

  static const labelPrimarySubtleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primarySubtle,
  );
}
