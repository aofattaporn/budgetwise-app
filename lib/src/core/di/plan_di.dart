import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/core/supabase/supabase_config.dart';
import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/repositories/plan_repository.dart';
import 'package:budget_wise/src/domain/usecase/plan/plan_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';

void setupPlanDI() {
  // Register the database client
  sl.registerLazySingleton(() => dbClient);

  // Register data layer
  sl.registerLazySingleton<PlanDataSource>(
      () => PlanRemoteDataSourceImpl(sl()));

  // Register Repository
  sl.registerFactory<PlanRepository>(
      () => PlanRepositoryImp(planDataSource: sl<PlanDataSource>()));

  // Register Use Cases
  sl.registerFactory<PlanUsecase>(
      () => PlanUsecase(planRepository: sl<PlanRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<PlanBloc>(() => PlanBloc(planUsecase: sl<PlanUsecase>()));
}
