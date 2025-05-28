import 'package:budget_wise/src/core/di/account_di.dart';
import 'package:budget_wise/src/core/di/common_di.dart';
import 'package:budget_wise/src/core/di/main_screen_di.dart';
import 'package:budget_wise/src/core/di/plan_di.dart';
import 'package:budget_wise/src/core/di/plan_item_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  commonDI();

  // Load DI from each feature
  setupMainScreenDI();
  setupPlanDI();
  setupPlanItemDI();
  setupAccountDI();
}
