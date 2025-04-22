import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/usecase/plan/plan_item_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanItemDI() {
  // Register data layer
  sl.registerLazySingleton<PlanItemDataSource>(
      () => PlanItemDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<PlanItemRepository>(() =>
      PlanRepositoryItemImp(planItemDataSource: sl<PlanItemDataSource>()));

  // Register Use Cases
  sl.registerFactory<PlanItemUsecase>(
      () => PlanItemUsecase(planItemRepository: sl<PlanItemRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<PlanItemBloc>(
      () => PlanItemBloc(planItemUsecase: sl<PlanItemUsecase>()));
}
