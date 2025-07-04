import 'package:bloc/bloc.dart';
import 'package:budget_wise/core/errors/not_found_error.dart';
import 'package:budget_wise/domain/usecases/plan_usecase.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_state.dart';

class PlanSelectorBloc extends Bloc<PlanSelectorEvent, PlanSelectorState> {
  final PlanUsecase useCase;

  PlanSelectorBloc(this.useCase) : super(PlanAllInitial()) {
    on<FetchAllMonthPlanEvent>((event, emit) async {
      emit(PlanAllLoading());
      try {
        final planList = await useCase.getAllPlans();
        emit(AllPlanLoaded(planList));
      } on NotfoundError {
        emit(NotFoundAnyPlans());
      } catch (e) {
        emit(PlanAllError("Failed to fetch current month's plan list"));
      }
    });

    on<InsertNewPlan>((event, emit) async {
      emit(PlanAllLoading());
      try {
        await useCase.createPlan(event.planDto);
        final planList = await useCase.getAllPlans();
        emit(AllPlanLoaded(planList));
      } on NotfoundError {
        emit(NotFoundAnyPlans());
      } catch (e) {
        emit(PlanAllError("Failed to fetch current month's plan list"));
      }
    });
  }
}
