import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'budget_plan_event.dart';
import 'budget_plan_state.dart';

class BudgetPlanBloc extends Bloc<BudgetPlanEvent, BudgetPlanState> {
  final GetPlanMonthlyUsecase getPlanMonthllyUsecase;

  BudgetPlanBloc({
    required this.getPlanMonthllyUsecase,
  }) : super(BudgetPlanInitial()) {
    on<LoadBudgetPlan>((event, emit) async {
      emit(BudgetPlanLoading());
      try {
        final planBudget = await getPlanMonthllyUsecase.call(null);
        emit(BudgetPlanLoaded(planMonthlyBudget: planBudget));
      } on BussinessError catch (e) {
        emit(BudgetPlanEmpty(e.desc));
      } catch (e) {
        emit(BudgetPlanError(e.toString()));
      }
    });
  }
}
