import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/repositories/planning_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  final PlanningRepository _planningRepository = PlanningRepository();

  double currentTotalUsage = 0;
  List<PlanEntity>? planning;

  // Constructor to initialize the AccountBloc with a repository
  PlansBloc() : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetPlansEvent>((event, emit) async {
      emit(GetPlanLoading());
      try {
        final List<PlanEntity> plans =
            await _planningRepository.getPlans(event.monthYear);
        currentTotalUsage =
            plans.fold(0, (sum, item) => sum + (item.usage ?? 0));
        planning = plans;
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
        emit(CreatePlanSuccess(data));
        emit(GetPlanSuccess(data, currentTotalUsage));
      } catch (error) {
        emit(CreatePlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<UpdatePlanEvent>((event, emit) async {
      emit(CreatePlanLoading());
      try {
        final data = await _planningRepository.updatePlanning(
            event.planning.planId ?? -1, event.planning);
        emit(UpdatePlanSuccess());
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
        currentTotalUsage =
            data.fold(0, (sum, item) => sum + (item.usage ?? 0));
        planning = data;
        emit(DeletePlanSuccess());
        emit(GetPlanSuccess(data, currentTotalUsage));
      } catch (error) {
        print(error);
        emit(CreatePlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<GetCurrentSpendingEvent>((event, emit) async {
      if (planning != null) {
        emit(GetPlanSuccess(planning!, currentTotalUsage));
      }
    });
  }
}
