import 'package:budget_wise/src/data/models/account.dart';

class Mocks {
  static final List<Account> listAccount = [
    Account(
        accountId: 1,
        accountName: "SCB",
        balance: 14000.0,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 1),
    Account(
        accountId: 2,
        accountName: "BBL",
        balance: 11588.33,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 2),
    Account(
        accountId: 3,
        accountName: "Cash",
        balance: 230.0,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 3),
  ];
}
