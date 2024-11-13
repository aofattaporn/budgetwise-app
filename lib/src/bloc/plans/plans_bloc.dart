import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/repositories/planning_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  final PlanningRepository _planningRepository = PlanningRepository();

  double currentTotalUsage = 0;

  List<PlanEntity> planningTranfer = [];
  List<PlanEntity> planningSaving = [];

  // Constructor to initialize the AccountBloc with a repository
  PlansBloc() : super(InitialState()) {
    // Event handler for fetching all plans
    on<GetPlansEvent>(_getPlanByMonthEvent);

    // Event handler for creating a new plan
    on<CreatePlanEvent>(_createPlanEvent);

    // Event handler for updating a plan
    on<UpdatePlanEvent>(_updatePlanEvent);

    // Event handler for deleting a plan
    on<DeletePlanEvent>(_deletePlanEvent);

    // Event handler for getting current spending
    on<GetCurrentSpendingEvent>(_getCurrentSpendingEvent);
  }

  List<PlanEntity> _filterListType(List<PlanEntity> data, String type) {
    return planningTranfer = data.where((item) => item.type == type).toList();
  }

  void _getPlanByMonthEvent(
    GetPlansEvent event,
    Emitter<PlansState> emit,
  ) async {
    try {
      emit(PlanLoadingProcess());
      final List<PlanEntity> plans =
          await _planningRepository.getPlans(event.monthYear);
      currentTotalUsage = plans.fold(0, (sum, item) => sum + (item.usage ?? 0));
      final tranfers = _filterListType(plans, Constants.tranfersType);
      final saving = _filterListType(plans, Constants.savingType);

      if (plans.isEmpty) {
        emit(PlanNotFound());
      }

      emit(SetPlanDataComplete(tranfers, saving, currentTotalUsage));
    } catch (error) {
      emit(GetPlanFailure(error.toString()));
    }
  }

  void _createPlanEvent(
    CreatePlanEvent event,
    Emitter<PlansState> emit,
  ) async {
    emit(CreatePlanLoading());
    try {
      final plans = await _planningRepository.createPlanning(event.planning);
      final tranfers = _filterListType(plans, Constants.tranfersType);
      final saving = _filterListType(plans, Constants.savingType);
      emit(SetPlanDataComplete(tranfers, saving, currentTotalUsage));
    } catch (error) {
      emit(CreatePlanFailure(error.toString()));
    }
  }

  void _updatePlanEvent(
    UpdatePlanEvent event,
    Emitter<PlansState> emit,
  ) async {
    emit(CreatePlanLoading());
    try {
      final plans = await _planningRepository.updatePlanning(
          event.planning.planId ?? -1, event.planning);
      final tranfers = _filterListType(plans, Constants.tranfersType);
      final saving = _filterListType(plans, Constants.savingType);
      emit(UpdatePlanSuccess());
      emit(SetPlanDataComplete(tranfers, saving, currentTotalUsage));
    } catch (error) {
      emit(CreatePlanFailure(error.toString()));
    }
  }

  void _deletePlanEvent(
    DeletePlanEvent event,
    Emitter<PlansState> emit,
  ) async {
    emit(DeletePlanLoading());
    try {
      final data = await _planningRepository.deletPlanning(event.planId);
      currentTotalUsage = data.fold(0, (sum, item) => sum + (item.usage ?? 0));
      planningTranfer = data.where((item) => item.type == "tranfers").toList();
      planningSaving = data.where((item) => item.type == "saving").toList();
      emit(DeletePlanSuccess());
      emit(SetPlanDataComplete(
          planningTranfer, planningSaving, currentTotalUsage));
    } catch (error) {
      emit(DeletePlanFailure(error.toString()));
    }
  }

  void _getCurrentSpendingEvent(
    GetCurrentSpendingEvent event,
    Emitter<PlansState> emit,
  ) async {
    final tranfers =
        planningTranfer.where((item) => item.type == "tranfers").toList();
    final saving =
        planningTranfer.where((item) => item.type == "saving").toList();
    emit(SetPlanDataComplete(tranfers, saving, currentTotalUsage));
  }
}
