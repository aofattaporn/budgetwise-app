import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/core/errors/not_found_error.dart';
import 'package:budget_wise/src/domain/usecase/plan_usecase.dart';
import 'current_plan_event.dart';
import 'current_plan_state.dart';

class CurrentPlanBloc extends Bloc<CurrentPlanEvent, CurrentPlanState> {
  final PlanUsecase useCase;
  CurrentPlanBloc(this.useCase) : super(CurrentPlanInitial()) {
    on<FetchCurrentPlanEvent>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        final plan = await useCase.getPlanByCurrentMonth();
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });

    on<FetchPlanByIdEvent>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        final plan = await useCase.getPlanByMonthId(event.planId);
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });
  }
}
