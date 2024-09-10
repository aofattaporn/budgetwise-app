import 'dart:ui';

import 'package:budget_wise/src/data/models/color_gradients.dart';

class ColorConstants {
  // String constant
  static const String successMessage = "You will be contacted by us very soon.";

  // Color constants
  static const Color primaryColor = Color(0xFF2196F3); // Blue color
  static const Color secondaryColor = Color(0xFFFFC107); // Amber color

  static const Color bgPrimary = Color.fromARGB(250, 250, 250, 100);

  static final List<ColorGradients> colorGradients = [
    ColorGradients(
      Color.fromARGB(255, 82, 29, 125),
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
  ];
}
