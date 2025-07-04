import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/features/plan/domain/usecases/plan_item_usecase.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanItemDI() {
  // Register data layer
  sl.registerFactory<PlanItemDataSource>(
      () => PlanItemRemoteDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<PlanItemRepository>(
      () => PlanItemRepositoryImp(dataSource: sl<PlanItemDataSource>()));

  // Register Use Cases
  sl.registerFactory<PlanItemUsecase>(() => PlanItemUsecase(
        planItemRepository: sl<PlanItemRepository>(),
        planRepository: sl<PlanRepository>(),
      ));

  // Register Bloc and inject the use case
  sl.registerFactory<PlanItemBloc>(() => PlanItemBloc(sl<PlanItemUsecase>()));
}
