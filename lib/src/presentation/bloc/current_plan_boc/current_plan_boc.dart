import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/core/errors/not_found_error.dart';
import 'package:budget_wise/src/domain/usecase/plan_usecase.dart';
import 'current_plan_event.dart';
import 'current_plan_state.dart';

class CurrentPlanBloc extends Bloc<CurrentPlanEvent, CurrentPlanState> {
  final PlanUsecase useCase;
  CurrentPlanBloc(this.useCase) : super(CurrentPlanInitial()) {
    on<FetchPlanInfoByIdEvent>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        const mockPlanId = "26471744-bd37-4e69-8c8b-cdd728d59c03";
        final _ = await useCase.getPlanAndPlanItemInfo(mockPlanId);
        final plan = await useCase.getPlanByCurrentMonth();
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });

    on<FetchCurrentPlanEvent>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        final x = await useCase
            .getPlanAndPlanItemInfo("26471744-bd37-4e69-8c8b-cdd728d59c03");

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

    on<DeletePlanById>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        await useCase.deletePlanById(event.planId);
        emit(CurrentPlanDeleted());
        final plan = await useCase.getPlanByCurrentMonth();
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });

    on<UpdateNewPlan>((event, emit) async {
      emit(CurrentPlanLoading());
      try {
        await useCase.updatePlan(event.planDto);
        emit(CurrentPlanDeleted());
        final plan = await useCase.getPlanByCurrentMonth();
        emit(CurrentPlanLoaded(plan!));
      } on NotfoundError {
        emit(CurrentPlanEmpty());
      } catch (e) {
        emit(CurrentPlanError("Failed to fetch current plan"));
      }
    });
  }
}
