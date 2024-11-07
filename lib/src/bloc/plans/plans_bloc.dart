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
        final tranfers =
            plans.where((item) => item.type == "tranfers").toList();
        final saving = plans.where((item) => item.type == "saving").toList();
        emit(GetPlanSuccess(tranfers, saving, currentTotalUsage));
      } catch (error) {
        emit(GetPlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<CreatePlanEvent>((event, emit) async {
      emit(CreatePlanLoading());
      try {
        final data = await _planningRepository.createPlanning(event.planning);
        final tranfers = data.where((item) => item.type == "tranfers").toList();
        final saving = data.where((item) => item.type == "saving").toList();
        emit(CreatePlanSuccess(data));
        emit(GetPlanSuccess(tranfers, saving, currentTotalUsage));
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
        final tranfers = data.where((item) => item.type == "tranfers").toList();
        final saving = data.where((item) => item.type == "saving").toList();
        emit(UpdatePlanSuccess());
        emit(GetPlanSuccess(tranfers, saving, currentTotalUsage));
      } catch (error) {
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
        final tranfers = data.where((item) => item.type == "tranfers").toList();
        final saving = data.where((item) => item.type == "saving").toList();
        planning = data;
        emit(DeletePlanSuccess());
        emit(GetPlanSuccess(tranfers, saving, currentTotalUsage));
      } catch (error) {
        print(error);
        emit(CreatePlanFailure(error.toString()));
      }
    });

    // Event handler for fetching all accounts
    on<GetCurrentSpendingEvent>((event, emit) async {
      if (planning != null) {
        final tranfers =
            planning!.where((item) => item.type == "tranfers").toList();
        final saving =
            planning!.where((item) => item.type == "saving").toList();
        emit(GetPlanSuccess(tranfers, saving, currentTotalUsage));
      }
    });
  }
}
