import 'package:bloc/bloc.dart';
import 'plan_event.dart';
import 'plan_state.dart';
import 'package:budget_wise/src/domain/usecase/plan_usecase.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanUsecase useCase;

  PlanBloc(this.useCase) : super(PlanInitial()) {
    on<FetchCurrentMonthPlanEvent>((event, emit) async {
      emit(PlanLoading());
      try {
        final plan = await useCase.getPlanByCurrentMonth();
        if (plan == null) {
          emit(PlanEmpty());
        } else {
          emit(PlanLoaded(plan));
        }
      } catch (e) {
        emit(PlanError("Failed to fetch current month's plan"));
      }
    });

    on<FetchAllMonthPlanEvent>((event, emit) async {
      emit(PlanLoading());
      try {
        final planList = await useCase.getAllPlans();
        emit(AllPlanLoaded(planList));
      } catch (e) {
        emit(PlanError("Failed to fetch current month's plan list"));
      }
    });
  }
}
