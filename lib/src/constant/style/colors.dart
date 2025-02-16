import 'dart:ui';

import 'package:budget_wise/src/models/color_gradients.dart';

class ColorConstants {
  static const Color primary = Color(0xFF9F86C0);
  static const Color priamryDark = Color(0xFF5E548E);
  static const Color primaryLigth = Color(0xFFBE95C4);
  static const Color primarySubtle = Color(0xFFD6BBDD);

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color dark = Color(0xFF191627);
  static const Color grey = Color.fromARGB(255, 59, 59, 59);
  static const Color greyLigth = Color.fromARGB(255, 124, 124, 124);
  static const Color greyDark = Color.fromARGB(255, 33, 33, 33);

  // color gradients Constants
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
