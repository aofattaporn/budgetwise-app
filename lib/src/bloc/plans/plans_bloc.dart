import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/data/repositories/planning_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  final PlanningRepository _planningRepository = PlanningRepository();

  // Constructor to initialize the AccountBloc with a repository
  PlansBloc() : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetPlansEvent>((event, emit) async {
      emit(GetPlanLoading());
      try {
        final data = await _planningRepository.getPlans();
        emit(GetPlanSuccess(data));
      } catch (error) {
        print(error);
        emit(GetPlanFailure(error.toString()));
      }
    });
  }
}
