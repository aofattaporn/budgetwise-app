import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/domain/usecases/get_all_plan_usecase.dart';
import 'package:budget_wise/presentation/bloc/budget_all_plan_bloc/budget_plan_event.dart';
import 'package:budget_wise/presentation/bloc/budget_all_plan_bloc/budget_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetAllPlanBloc extends Bloc<BudgetAllPlanEvent, BudgetAllPlanState> {
  final GetAllPlanUsecase getAllPlanUsecase;

  BudgetAllPlanBloc({
    required this.getAllPlanUsecase,
  }) : super(BudgetPlanInitial()) {
    on<LoadAllBudgetPlan>((event, emit) async {
      emit(GetAllPlanLoading());
      try {
        final planBudget = await getAllPlanUsecase.call(null);
        print("Plan Budget: ${planBudget.length}");
        emit(GetAllPlanLoaded(listPlanDto: planBudget));
      } on BussinessError catch (e) {
        emit(GetAllPlanError(e.desc));
      } catch (e) {
        print("Error in BudgetAllPlanBloc: ${e.toString()}");
        emit(GetAllPlanError(e.toString()));
      }
    });
  }
}
