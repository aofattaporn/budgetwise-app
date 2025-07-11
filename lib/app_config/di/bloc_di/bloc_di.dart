import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/budget_wise_app.dart';
import 'package:budget_wise/domain/usecases/get_all_plan_item_by_planId.dart';
import 'package:budget_wise/domain/usecases/get_all_plan_usecase.dart';
import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
import 'package:budget_wise/presentation/bloc/budget_all_plan_bloc/budget_plan_bloc.dart';
import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_bloc.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<BudgetPlanBloc>(
      create: (context) => getIt<BudgetPlanBloc>(),
    ),
    BlocProvider<BudgetAllPlanBloc>(
      create: (context) => getIt<BudgetAllPlanBloc>(),
    ),
    BlocProvider<PlanItemBloc>(
      create: (context) => getIt<PlanItemBloc>(),
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
    ),
  ];
}

void blocDI() {
  // Register Bloc and inject the use case
  getIt.registerFactory<BudgetPlanBloc>(() => BudgetPlanBloc(
        getPlanMonthllyUsecase: getIt<GetPlanMonthlyUsecase>(),
      ));
  getIt.registerFactory<BudgetAllPlanBloc>(() => BudgetAllPlanBloc(
        getAllPlanUsecase: getIt<GetAllPlanUsecase>(),
      ));
  getIt.registerFactory<PlanItemBloc>(() => PlanItemBloc(
        getAllPlanItemByPlanid: getIt<GetAllPlanItemByPlanid>(),
        budgetPlanBloc: getIt<BudgetPlanBloc>(),
      ));
}
