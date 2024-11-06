import 'package:budget_wise/src/models/entity/budget_account_entity.dart';

class Mocks {
  static final List<BudgetAccountEntity> listAccount = [
    BudgetAccountEntity(
        accountId: 1,
        accountName: "SCB",
        balance: 14000.0,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 1),
    BudgetAccountEntity(
        accountId: 2,
        accountName: "BBL",
        balance: 11588.33,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 2),
    BudgetAccountEntity(
        accountId: 3,
        accountName: "Cash",
        balance: 230.0,
        createDate: DateTime.now(),
        updatePlanDate: DateTime.now(),
        colorIndex: 3),
  ];
}
