import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/domain/usecases/plan_item_usecase.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupPlanItemDI() {
  // Register data layer
  getIt.registerFactory<PlanItemDataSource>(
      () => PlanItemRemoteDataSourceImpl(getIt<SupabaseClient>()));

  // Register Repository
  getIt.registerFactory<PlanItemRepository>(
      () => PlanItemRepositoryImp(dataSource: getIt<PlanItemDataSource>()));

  // Register Use Cases
  getIt.registerFactory<PlanItemUsecase>(() => PlanItemUsecase(
        planItemRepository: getIt<PlanItemRepository>(),
        planRepository: getIt<PlanRepository>(),
      ));

  // Register Bloc and inject the use case
  getIt.registerFactory<PlanItemBloc>(
      () => PlanItemBloc(getIt<PlanItemUsecase>()));
}
