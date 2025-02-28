import 'package:budget_wise/src/bloc/plan_item_boc/plan_item_event.dart';
import 'package:budget_wise/src/bloc/plan_item_boc/plan_item_state.dart';
import 'package:budget_wise/src/configs/log/logger_config.dart';
import 'package:budget_wise/src/repositories/plan_item_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemBloc extends Bloc<PlanItemEvent, PlanItemsState> {
  final logger = getLogger('PlanItemBloc');
  final planItemBloc = PlanItemRepository();

  PlanItemBloc() : super(InitialState()) {
    on<GetPlanItemsCurrentMonthEvent>(_getPlanItemsCurrentMonthLoading);
  }

  void _getPlanItemsCurrentMonthLoading(
    GetPlanItemsCurrentMonthEvent event,
    Emitter<PlanItemsState> emit,
  ) async {
    final response = await planItemBloc.getPlanItemsCurrentMonth();
    logger.i("Fetch plan item current item length: {${response.length}}");
    emit(GetPlanItemsCurrentMonthSuccess(response));
  }
}
