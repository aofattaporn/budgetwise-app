import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// {@template app_text_styles}
/// Class that contains all text styles used in the app.
/// {@endtemplate}
class AppTextStyles {
  AppTextStyles._();

  // ============================================================================
  // =                                  DISPLAY                                =
  // ============================================================================

  // ====> AppColors.dark

  static const displayLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static const displayMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const displaySmall = TextStyle(
    color: AppColors.dark,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // ====> AppColors.priamryDark

  static const displayPriamryDarkLarge = TextStyle(
    color: AppColors.priamryDark,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static const displayPriamryDarkMedium = TextStyle(
    color: AppColors.priamryDark,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const displayPriamryDarkSmall = TextStyle(
    color: AppColors.priamryDark,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // ============================================================================
  // =                                 HEADLINE                                =
  // ============================================================================

  static const headlineLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const headlineMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const headlineSmall = TextStyle(
    color: AppColors.dark,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ============================================================================
  // =                                   BODY                                  =
  // ============================================================================

  static const bodyLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w100,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    color: AppColors.dark,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // ============================================================================
  // =                                   LABEL                                 =
  // ============================================================================

  static const labelLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const labelMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const labelSmall = TextStyle(
    color: AppColors.dark,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // ====> Add-ons

  static const labelGraySmall = TextStyle(
    color: AppColors.grayLight,
    fontSize: 12,
    height: 1.4,
  );

  static const labelPrimarySmall = TextStyle(
    color: AppColors.priamryDark,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.4,
  );
}
