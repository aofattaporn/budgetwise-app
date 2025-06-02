import 'package:budget_wise/app_config/di/account_di.dart';
import 'package:budget_wise/app_config/di/common_di.dart';
import 'package:budget_wise/app_config/di/plan_di.dart';
import 'package:budget_wise/app_config/di/plan_item_di.dart';
import 'package:budget_wise/app_config/di/transaction_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  commonDI();

  setupPlanDI();
  setupPlanItemDI();
  setupAccountDI();
  setupTransactionDI();
}
