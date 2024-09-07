import 'dart:ui';

import 'package:budget_wise/src/data/models/Account.dart';

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
}
