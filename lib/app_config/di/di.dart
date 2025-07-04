import 'package:budget_wise/app_config/supabase/supabase_config.dart';
import 'package:budget_wise/data/datasources/plan_datasource.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
import 'package:budget_wise/domain/usecases/plan_usecase.dart';
import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // comon di
  getIt.registerLazySingleton<SupabaseClient>(() => dbClient);

  // Register Datasource
  getIt.registerLazySingleton<PlanDataSource>(
      () => PlanRemoteDataSourceImpl(client: getIt<SupabaseClient>()));

  // Register Repository
  getIt.registerFactory<PlanRepository>(
      () => PlanRepositoryImp(planDataSource: getIt<PlanDataSource>()));

  // Register Use Cases
  getIt.registerFactory<PlanUsecase>(
      () => PlanUsecase(planRepository: getIt<PlanRepository>()));
  getIt.registerFactory<GetPlanMonthllyUsecase>(
      () => GetPlanMonthllyUsecase(planRepository: getIt<PlanRepository>()));

  // Register Bloc and inject the use case
  getIt.registerFactory<BudgetPlanBloc>(
      () => BudgetPlanBloc(getIt<GetPlanMonthllyUsecase>()));
}
