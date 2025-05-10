import 'package:flutter/material.dart';

/// {@template app_colors}
/// Standardized color palette for BudgetWise Design System.
/// {@endtemplate}
class AppColors {
  AppColors._();

  // === Brand Colors ===
  static const Color primary = Color(0xFF9F86C0);
  static const Color primaryDark = Color(0xFF5E548E);
  static const Color primaryLight = Color(0xFFBE95C4);
  static const Color primarySubtle = Color(0xFFD6BBDD);
  static const Color primarySubtleLight = Color(0xFFF2E8F5);

  // === Backgrounds ===
  static const Color background = white;
  static const Color backgroundDark = grayDark900;
  static const Color surface = Color(0xFFF9FAFB);
  static const Color surfaceDark = grayDark800;

  // === Text Colors ===
  static const Color textPrimary = grayDark900;
  static const Color textSecondary = grayDark700;
  static const Color textTertiary = grayDark500;
  static const Color textOnPrimary = white;

  // === Border & Divider ===
  static const Color divider = grayDark200;
  static const Color border = grayDark300;

  // === State Colors ===
  static const Color success = Color(0xFF52C41A);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFFF4D4F);

  // === Gray Palette ===
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color gray50 = Color(0xFFFCFCFD);
  static const Color gray100 = Color(0xFFF9FAFB);
  static const Color gray200 = Color(0xFFEAECF0);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF101828);

  // === Dark Palette ===
  static const Color grayDark100 = Color(0xFFF5F5F6);
  static const Color grayDark200 = Color(0xFFECECED);
  static const Color grayDark300 = Color(0xFFCECFD2);
  static const Color grayDark400 = Color(0xFF94969C);
  static const Color grayDark500 = Color(0xFF85888E);
  static const Color grayDark600 = Color(0xFF61646C);
  static const Color grayDark700 = Color(0xFF333741);
  static const Color grayDark800 = Color(0xFF1F242F);
  static const Color grayDark900 = Color(0xFF0C111D);
}
