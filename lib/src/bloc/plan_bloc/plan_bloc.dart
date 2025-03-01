import 'package:budget_wise/src/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/configs/log/logger_config.dart';
import 'package:budget_wise/src/repositories/plan_item_repository.dart';
import 'package:budget_wise/src/repositories/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final logger = getLogger('PlanBloc');
  final planRepository = PlanRepository();
  final planItemRepository = PlanItemRepository();

  PlanBloc() : super(InitialState()) {
    on<GetPlanByMonthEvent>(_getPlanByMonth);
  }

  void _getPlanByMonth(
    GetPlanByMonthEvent event,
    Emitter<PlanState> emit,
  ) async {
    final planInfo = await planRepository.getPlanCurrentMonth();
    logger.i(
        "Fetch plan current month {${planInfo.startDate}} - {${planInfo.endDate}}, amount: {${planInfo.totalBudget}}");

    final planItems = await planItemRepository.getPlanItemsCurrentMonth();
    logger.i("Fetch plan item current item length: {${planItems.length}}");

    emit(GetPlanCurrentMonthSuccess(planInfo, planItems));
  }
}
