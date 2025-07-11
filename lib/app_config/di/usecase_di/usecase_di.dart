import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/domain/usecases/get_all_plan_item_by_planId.dart';
import 'package:budget_wise/domain/usecases/get_all_plan_usecase.dart';
import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
import 'package:budget_wise/domain/usecases/plan_usecase.dart';

void usecaseDI() {
  // Register Use Cases
  getIt.registerFactory<PlanUsecase>(
      () => PlanUsecase(planRepository: getIt<PlanRepository>()));
  getIt.registerFactory<GetPlanMonthlyUsecase>(() => GetPlanMonthlyUsecase(
        planRepository: getIt<PlanRepository>(),
        transactionRepository: getIt<TransactionRepositoryImp>(),
      ));
  getIt.registerFactory<GetAllPlanUsecase>(() => GetAllPlanUsecase(
        planRepository: getIt<PlanRepository>(),
      ));
  getIt.registerFactory<GetAllPlanItemByPlanid>(() => GetAllPlanItemByPlanid(
        planRepository: getIt<PlanItemRepository>(),
      ));
}
