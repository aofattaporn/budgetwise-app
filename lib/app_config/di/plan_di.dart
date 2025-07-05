// import 'package:budget_wise/app_config/di/di.dart';
// import 'package:budget_wise/data/datasources/plan_datasource.dart';
// import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
// import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
// import 'package:budget_wise/domain/usecases/plan_usecase.dart';
// import 'package:budget_wise/presentation/bloc/current_plan_boc/current_plan_boc.dart';
// import 'package:budget_wise/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// void setupPlanDI() {
//   // Register data layer
//   getIt.registerLazySingleton<PlanDataSource>(
//       () => PlanRemoteDataSourceImpl(getIt<SupabaseClient>()));

//   // Register Repository
//   getIt.registerFactory<PlanRepository>(
//       () => PlanRepositoryImp(planDataSource: getIt<PlanDataSource>()));

//   // Register Use Cases
//   getIt.registerFactory<PlanUsecase>(
//       () => PlanUsecase(planRepository: getIt<PlanRepository>()));
//   getIt.registerFactory<GetPlanMonthllyUsecase>;

//   // Register Bloc and inject the use case
//   // sl.registerFactory<BudgetPlanBloc>(()=> sl<GetPlanMonthllyUsecase>());
//   getIt.registerFactory<CurrentPlanBloc>(
//       () => CurrentPlanBloc(getIt<PlanUsecase>()));
//   getIt.registerFactory<PlanSelectorBloc>(
//       () => PlanSelectorBloc(getIt<PlanUsecase>()));
// }
