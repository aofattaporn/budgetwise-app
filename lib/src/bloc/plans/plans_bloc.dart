import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
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
        final List<Planning> plans = await _planningRepository.getPlans();
        final double currentTotalUsage =
            plans.fold(0, (sum, item) => sum + (item.usage ?? 0));
        emit(GetPlanSuccess(plans, currentTotalUsage));
      } catch (error) {
        print(error);
        emit(GetPlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<CreatePlanEvent>((event, emit) async {
      emit(CreatePlanLoading());
      try {
        final data = await _planningRepository.createPlanning(event.planning);
        final double currentTotalUsage =
            data.fold(0, (sum, item) => sum + (item.usage ?? 0));
        emit(CreatePlanSuccess(data));
        emit(GetPlanSuccess(data, currentTotalUsage));
      } catch (error) {
        print(error);
        emit(CreatePlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<DeletePlanEvent>((event, emit) async {
      emit(DeletePlanLoading());
      try {
        final data = await _planningRepository.deletPlanning(event.planId);
        final double currentTotalUsage =
            data.fold(0, (sum, item) => sum + (item.usage ?? 0));
        emit(DeletePlanSuccess());
        emit(GetPlanSuccess(data, currentTotalUsage));
      } catch (error) {
        print(error);
        emit(CreatePlanFailure(error.toString()));
      }
    });
  }
}
