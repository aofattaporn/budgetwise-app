import 'package:flutter/material.dart';

/// {@template app_colors}
/// Colors class for themes which provides direct access with static fields.
/// {@endtemplate}
class AppColors {
  AppColors._();

  /// The color common
  static const white = Colors.white;
  static const Color dark = Color(0xFF191627);
  static const black = Colors.black;
  static const transparent = Colors.transparent;

  static const Color primary = Color(0xFF9F86C0);
  static const Color priamryDark = Color(0xFF5E548E);
  static const Color primaryLigth = Color(0xFFBE95C4);
  static const Color primarySubtle = Color(0xFFD6BBDD);

  static const MaterialColor error = MaterialColor(0xFFFF4D4F, {
    50: Color(0xFFFFE5E5),
    100: Color(0xFFFFBFBF),
    200: Color(0xFFFF9999),
    300: Color(0xFFFF7373),
    400: Color(0xFFFF4D4F), // Primary error color
    500: Color(0xFFE63946),
    600: Color(0xFFCC333F),
    700: Color(0xFFB32D38),
    800: Color(0xFF992731),
    900: Color(0xFF7F212A),
  });

  static const MaterialColor warning = MaterialColor(0xFFFFC107, {
    50: Color(0xFFFFF8E1),
    100: Color(0xFFFFECB3),
    200: Color(0xFFFFE082),
    300: Color(0xFFFFD54F),
    400: Color(0xFFFFC107), // Primary warning color
    500: Color(0xFFFFB300),
    600: Color(0xFFFFA000),
    700: Color(0xFFFF8F00),
    800: Color(0xFFFF6F00),
    900: Color(0xFFFF5722),
  });

  static const MaterialColor success = MaterialColor(0xFF52C41A, {
    50: Color(0xFFE6F7E6),
    100: Color(0xFFBFE6BF),
    200: Color(0xFF99D699),
    300: Color(0xFF73C673),
    400: Color(0xFF52C41A), // Primary success color
    500: Color(0xFF46B417),
    600: Color(0xFF3A9E14),
    700: Color(0xFF2E8811),
    800: Color(0xFF23720E),
    900: Color(0xFF195C0B),
  });

  /// Light gray color palette.
  static const grayLight = MaterialColor(0xFF667085, {
    50: Color(0xFFFCFCFD),
    100: Color(0xFFF9FAFB),
    150: Color(0xFFF2F4F7),
    200: Color(0xFFEAECF0),
    250: Color(0xFFD0D5DD),
    300: Color(0xFF98A2B3),
    400: Color(0xFF667085),
    500: Color(0xFF475467),
    600: Color(0xFF344054),
    700: Color(0xFF182230),
    800: Color(0xFF101828),
    900: Color(0xFF0C111D),
  });

  /// Dark gray color palette.
  static const grayDark = MaterialColor(0xFF85888E, {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F6),
    150: Color(0xFFF0F1F1),
    200: Color(0xFFECECED),
    250: Color(0xFFCECFD2),
    300: Color(0xFF94969C),
    400: Color(0xFF85888E),
    500: Color(0xFF61646C),
    600: Color(0xFF333741),
    700: Color(0xFF1F242F),
    800: Color(0xFF161B26),
    900: Color(0xFF0C111D),
  });
}
