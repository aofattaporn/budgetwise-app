import 'package:bloc/bloc.dart';
import 'package:budget_wise/core/errors/not_found_error.dart';
import 'package:budget_wise/features/plan/domain/usecases/plan_usecase.dart';
import 'current_plan_event.dart';
import 'current_plan_state.dart';

class CurrentPlanBloc extends Bloc<CurrentPlanEvent, CurrentPlanState> {
  final PlanUsecase useCase;
  CurrentPlanBloc(this.useCase) : super(CurrentPlanInitial()) {
    Future<void> emitCurrentPlan(Emitter<CurrentPlanState> emit) async {
      try {
        final plan = await useCase.getPlanByCurrentMonth();
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    }

    on<FetchCurrentPlanEvent>((event, emit) async {
      emit(CurrentPlanLoading());
      await emitCurrentPlan(emit);
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

    on<DeletePlanById>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        await useCase.deletePlanById(event.planId);
        emit(CurrentPlanDeleted());
        await emitCurrentPlan(emit);
      } catch (e) {
        emit(CurrentPlanError("Failed to delete plan"));
      }
    });

    on<UpdateNewPlan>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        await useCase.updatePlan(event.planDto);
        emit(CurrentPlanDeleted());
        await emitCurrentPlan(emit);
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });
  }
}
