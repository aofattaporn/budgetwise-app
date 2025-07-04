import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/datasources/plan_datasource.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/features/plan/domain/usecases/plan_usecase.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanDI() {
  // Register data layer
  sl.registerLazySingleton<PlanDataSource>(
      () => PlanRemoteDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<PlanRepository>(
      () => PlanRepositoryImp(planDataSource: sl<PlanDataSource>()));

  // Register Use Cases
  sl.registerFactory<PlanUsecase>(
      () => PlanUsecase(planRepository: sl<PlanRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<CurrentPlanBloc>(() => CurrentPlanBloc(sl<PlanUsecase>()));
  sl.registerFactory<PlanSelectorBloc>(
      () => PlanSelectorBloc(sl<PlanUsecase>()));
}
