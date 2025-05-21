import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
import 'package:budget_wise/src/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/usecase/plan_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanDI() {
  // Register data layer
  sl.registerLazySingleton<PlanDataSource>(
      () => PlanRemoteDataSourceImpl(sl<SupabaseClient>()));
  sl.registerLazySingleton<TransactionDatasource>(
      () => TransactionDatasourceImpl(client: sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<PlanRepository>(() => PlanRepositoryImp(
        planDataSource: sl<PlanDataSource>(),
        transactionDatasource: sl<TransactionDatasource>(),
      ));

  // Register Use Cases
  sl.registerFactory<PlanUsecase>(
      () => PlanUsecase(planRepository: sl<PlanRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<CurrentPlanBloc>(() => CurrentPlanBloc(sl<PlanUsecase>()));
  sl.registerFactory<PlanSelectorBloc>(
      () => PlanSelectorBloc(sl<PlanUsecase>()));
}
