import 'package:budget_wise/domain/usecases/get_plan_monthlly_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'budget_plan_event.dart';
import 'budget_plan_state.dart';

class BudgetPlanBloc extends Bloc<BudgetPlanEvent, BudgetPlanState> {
  final GetPlanMonthllyUsecase _getPlanMonthllyUsecase;
  BudgetPlanBloc(this._getPlanMonthllyUsecase) : super(BudgetPlanInitial()) {
    on<LoadBudgetPlan>((event, emit) async {
      emit(BudgetPlanLoading());
      try {
        final planBudget = await _getPlanMonthllyUsecase.call(null);
        emit(BudgetPlanLoaded(planMonthlyBudget: planBudget));
      } catch (e) {
        emit(BudgetPlanError(e.toString()));
      }
    });
  }
}
