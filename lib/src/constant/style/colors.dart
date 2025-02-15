import 'dart:ui';

import 'package:budget_wise/src/models/color_gradients.dart';

class ColorConstants {
  /// **
  /// color Constants
  /// **
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFFC107);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color bgPrimary = Color.fromARGB(250, 250, 250, 100);

  /// **
  /// color gradients Constants
  /// **
  static final List<ColorGradientsModel> colorGradients = [
    ColorGradientsModel(
      const Color.fromRGBO(33, 31, 47, 1),
      const Color.fromRGBO(145, 140, 169, 1),
    ),
    ColorGradientsModel(
      const Color.fromARGB(255, 47, 10, 77),
      const Color.fromRGBO(108, 51, 163, 1),
    ),
    ColorGradientsModel(
      const Color.fromRGBO(25, 23, 20, 1),
      const Color.fromRGBO(34, 52, 174, 1),
    ),
    ColorGradientsModel(
      const Color.fromRGBO(0, 0, 0, 1),
      const Color.fromRGBO(22, 109, 59, 1),
    ),
    ColorGradientsModel(
      const Color.fromRGBO(25, 23, 20, 1),
      const Color.fromRGBO(178, 143, 18, 1),
    ),
    ColorGradientsModel(
      const Color.fromRGBO(184, 46, 31, 1),
      const Color.fromRGBO(242, 180, 125, 1),
    ),
    ColorGradientsModel(
      const Color.fromRGBO(68, 0, 11, 1),
      const Color.fromRGBO(224, 69, 95, 1),
    ),
  ];
}
