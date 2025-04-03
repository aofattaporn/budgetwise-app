import 'package:budget_wise/src/domain/usecase/plan/plan_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanUsecase planUsecase;

  PlanBloc({required this.planUsecase}) : super(PlanInitial()) {
    on<FetchCurrentMonthPlan>(_onFetchCurrentMonthPlan);
    on<FetchtPlanByMId>(_onFetchtPlanById);
  }

  Future<void> _onFetchCurrentMonthPlan(
      FetchCurrentMonthPlan event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final plan = await planUsecase.getPlanByCurrentMonth();
      if (plan != null) {
        emit(PlanLoaded(plan));
      } else {
        emit(PlanNotFound());
      }
    } catch (e) {
      emit(PlanError(e.toString()));
    }
  }

  Future<void> _onFetchtPlanById(
      FetchtPlanByMId event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final plan = await planUsecase.getPlanByMonthId(event.id);
      if (plan != null) {
        emit(PlanLoaded(plan));
      } else {
        emit(PlanNotFound());
      }
    } catch (e) {
      emit(PlanError(e.toString()));
    }
  }
}
