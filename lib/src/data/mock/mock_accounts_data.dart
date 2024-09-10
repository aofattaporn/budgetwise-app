import 'dart:ui';

import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/color_gradients.dart';

class Mocks {
  static final List<Account> listAccount = [
    Account(
      accountId: 1, // Mocked accountId
      accountName: "SCB",
      balance: 14000.0,
      createDate: DateTime.now(),
      updatePlanDate: DateTime.now(), // Mocked updatePlanDate
      colorStart: const Color.fromARGB(255, 82, 29, 125),
      colorEnd: const Color.fromRGBO(108, 51, 163, 1),
    ),
    Account(
      accountId: 2, // Mocked accountId
      accountName: "BBL",
      balance: 11588.33,
      createDate: DateTime.now(),
      updatePlanDate: DateTime.now(), // Mocked updatePlanDate
      colorStart: const Color.fromRGBO(25, 23, 20, 1),
      colorEnd: const Color.fromRGBO(34, 52, 174, 1),
    ),
    Account(
      accountId: 3, // Mocked accountId
      accountName: "Cash",
      balance: 230.0,
      createDate: DateTime.now(),
      updatePlanDate: DateTime.now(), // Mocked updatePlanDate
      colorStart: const Color.fromRGBO(0, 0, 0, 1),
      colorEnd: const Color.fromRGBO(22, 109, 59, 1),
    ),
  ];

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
