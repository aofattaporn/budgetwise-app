import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// {@template app_text_styles}
/// Class that contains all text styles used in the app.
/// {@endtemplate}
class AppTextStyles {
  AppTextStyles._();

  // ====================== display =================================

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

  // ====> AppColors.dark

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

  // ====================== head =================================

  /// Headline large
  static const headlineLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Headline medium
  static const headlineMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Headline small
  static const headlineSmall = TextStyle(
    color: AppColors.dark,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ====================== body =================================

  /// Body large
  static const bodyLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w100,
    height: 1.5,
  );

  /// Body medium (default text)
  static const bodyMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body small
  static const bodySmall = TextStyle(
    color: AppColors.dark,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Label large (e.g., buttons)
  static const labelLarge = TextStyle(
    color: AppColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Label medium
  static const labelMedium = TextStyle(
    color: AppColors.dark,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Label small
  static const labelSmall = TextStyle(
    color: AppColors.dark,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // add-onc
  static const labelGraySmall = TextStyle(
    color: AppColors.grayLight,
    fontSize: 12,
    height: 1.4,
  );

  // add-onc
  static const labelPrimarySmall = TextStyle(
    color: AppColors.priamryDark,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.4,
  );
}
