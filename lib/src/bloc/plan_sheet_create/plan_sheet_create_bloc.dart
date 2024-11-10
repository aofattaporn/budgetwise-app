import 'package:budget_wise/src/bloc/plan_sheet_create/plan_sheet_create_event.dart';
import 'package:budget_wise/src/bloc/plan_sheet_create/plan_sheet_create_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanSheetCreateBloc
    extends Bloc<PlanSheetCreateEvent, PlanSheetCreateState> {
  DateTime monthYear = DateTime.now();

  PlanSheetCreateBloc() : super(PlansOverviewInitial()) {
    on<PlanSheetCreateEvent>(_setterPlanOverview);
  }

  void _setterPlanOverview(
    PlanSheetCreateEvent event,
    Emitter<PlanSheetCreateState> emit,
  ) async {
    emit(PlansOverviewInitial());
    emit(const PickerMonthSuccess());
  }
}
