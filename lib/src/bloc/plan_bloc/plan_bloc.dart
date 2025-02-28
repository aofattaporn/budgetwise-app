import 'package:budget_wise/src/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/configs/log/logger_config.dart';
import 'package:budget_wise/src/models/entity/plan.dart';
import 'package:budget_wise/src/repositories/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final logger = getLogger('PlanBloc');
  final planRepository = PlanRepository();
  Plan? _cachedPlan;

  PlanBloc() : super(InitialState()) {
    on<GetPlanByMonthEvent>(_getPlanByMonth);
    on<GetAlreadtPlanCurrentMonth>(_getAlreadtPlanCurrentMonth);
  }

  void _getPlanByMonth(
    GetPlanByMonthEvent event,
    Emitter<PlanState> emit,
  ) async {
    final response = await planRepository.getPlanCurrentMonth();
    _cachedPlan = response;
    logger.i(
        "Fetch plan current month {${response.startDate}} - {${response.endDate}}, amount: {${response.totalBudget}}");
    emit(GetPlanCurrentMonthSuccess(response));
  }

  void _getAlreadtPlanCurrentMonth(
    GetAlreadtPlanCurrentMonth event,
    Emitter<PlanState> emit,
  ) async {
    if (_cachedPlan != null) {
      final response = _cachedPlan!;
      logger.i(
          "Using cached plan current month {${response.startDate}} - {${response.endDate}}, amount: {${response.totalBudget}}");
      emit(GetPlanCurrentMonthSuccess(response));
    } else {
      logger.e('[Error] : Plan data not available in cache.');
      emit(PlanError("Plan data not available."));
    }
  }
}
