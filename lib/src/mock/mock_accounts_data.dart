import 'dart:ui';

import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/data/models/color_gradients.dart';

class Mocks {
  static final List<Account> listAcount = [
    Account(
      "SCB",
      14000.0,
      DateTime.now(),
      const Color.fromARGB(255, 82, 29, 125),
      const Color.fromRGBO(108, 51, 163, 1),
    ),
    Account(
      "BBL",
      11588.33,
      DateTime.now(),
      const Color.fromRGBO(25, 23, 20, 1),
      const Color.fromRGBO(34, 52, 174, 1),
    ),
    Account(
      "Cash",
      230,
      DateTime.now(),
      const Color.fromRGBO(0, 0, 0, 1),
      const Color.fromRGBO(22, 109, 59, 1),
    ),
  ];

  final List<ColorGradients> colorGradients = [
    ColorGradients(
        Color.fromARGB(255, 82, 29, 125), Color.fromRGBO(108, 51, 163, 1)),
    ColorGradients(
        Color.fromRGBO(25, 23, 20, 1), Color.fromRGBO(34, 52, 174, 1)),
    ColorGradients(Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(22, 109, 59, 1)),
  ];
}
