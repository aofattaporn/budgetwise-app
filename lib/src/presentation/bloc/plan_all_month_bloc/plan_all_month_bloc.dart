import 'package:budget_wise/src/domain/usecase/plan/plan_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanAllMonthBloc extends Bloc<PlanAllMonthEvent, PlanAllMonthState> {
  final PlanUsecase planUsecase;

  PlanAllMonthBloc({required this.planUsecase}) : super(PlanAllMonthInitial()) {
    on<FetchAllPlans>(_onFetchAllPlans);
  }

  Future<void> _onFetchAllPlans(
      FetchAllPlans event, Emitter<PlanAllMonthState> emit) async {
    emit(AllPlanLoading());
    try {
      final plans = await planUsecase.getAllPlans();
      emit(AllPlanLoaded(plans: plans));
    } catch (e) {
      emit(PlanAllMonthError(e.toString()));
    }
  }
}
