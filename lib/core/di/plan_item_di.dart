import 'package:budget_wise/core/di/di.dart';
import 'package:budget_wise/features/plan/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/features/account/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/usecase/plan_item_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanItemDI() {
  // Register data layer
  sl.registerFactory<PlanItemDataSource>(
      () => PlanItemRemoteDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<PlanItemRepository>(
      () => PlanItemRepositoryImp(dataSource: sl<PlanItemDataSource>()));

  // Register Use Cases
  sl.registerFactory<PlanItemUsecase>(
      () => PlanItemUsecase(planItemRepository: sl<PlanItemRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<PlanItemBloc>(() => PlanItemBloc(sl<PlanItemUsecase>()));
}
