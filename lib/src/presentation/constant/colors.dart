import 'dart:ui';

import 'package:budget_wise/src/data/models/color_gradients.dart';

class ColorConstants {
  // String constant
  static const String successMessage = "You will be contacted by us very soon.";

  // Color constants
  static const Color primaryColor = Color(0xFF2196F3); // Blue color
  static const Color secondaryColor = Color(0xFFFFC107); // Amber color
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color bgPrimary = Color.fromARGB(250, 250, 250, 100);

  static final List<ColorGradients> colorGradients = [
    ColorGradients(
      Color.fromRGBO(33, 31, 47, 1),
      Color.fromRGBO(145, 140, 169, 1),
    ),
    ColorGradients(
      Color.fromARGB(255, 47, 10, 77),
      Color.fromRGBO(108, 51, 163, 1),
    ),
    ColorGradients(
      Color.fromRGBO(25, 23, 20, 1),
      Color.fromRGBO(34, 52, 174, 1),
    ),
    ColorGradients(
      Color.fromRGBO(0, 0, 0, 1),
      Color.fromRGBO(22, 109, 59, 1),
    ),
    ColorGradients(
      Color.fromRGBO(25, 23, 20, 1),
      Color.fromRGBO(178, 143, 18, 1),
    ),
    ColorGradients(
      Color.fromRGBO(184, 46, 31, 1),
      Color.fromRGBO(242, 180, 125, 1),
    ),
    ColorGradients(
      Color.fromRGBO(68, 0, 11, 1),
      Color.fromRGBO(224, 69, 95, 1),
    ),
  ];
}
