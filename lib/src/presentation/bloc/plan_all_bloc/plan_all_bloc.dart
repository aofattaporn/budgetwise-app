import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/domain/usecase/plan_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_all_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_all_state.dart';

class PlanAllBloc extends Bloc<PlanAllEvent, PlanAllState> {
  final PlanUsecase useCase;

  PlanAllBloc(this.useCase) : super(PlanAllInitial()) {
    on<FetchAllMonthPlanEvent>((event, emit) async {
      emit(PlanAllLoading());
      try {
        final planList = await useCase.getAllPlans();
        emit(AllPlanLoaded(planList));
      } catch (e) {
        emit(PlanAllError("Failed to fetch current month's plan list"));
      }
    });
  }
}
