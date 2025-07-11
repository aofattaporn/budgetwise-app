import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/datasources/account_datasource.dart';
import 'package:budget_wise/data/datasources/plan_datasource.dart';
import 'package:budget_wise/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';

void repositoriesDI() {
  // Register Repository
  getIt.registerFactory<PlanRepository>(
      () => PlanRepositoryImp(planDataSource: getIt<PlanDataSource>()));
  getIt.registerFactory<PlanItemRepository>(
      () => PlanItemRepositoryImp(dataSource: getIt<PlanItemDataSource>()));
  getIt.registerFactory<TransactionRepositoryImp>(() =>
      TransactionRepositoryImp(dataSource: getIt<TransactionDataSource>()));
  getIt.registerFactory<AccountRepository>(
      () => AccountRepositoryImp(dataSource: getIt<AccountDataSource>()));
}
