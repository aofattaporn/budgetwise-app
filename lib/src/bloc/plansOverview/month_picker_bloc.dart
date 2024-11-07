// pls to write lboc

import 'package:budget_wise/src/bloc/plansOverview/month_picker_event.dart';
import 'package:budget_wise/src/bloc/plansOverview/month_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthPickerBloc extends Bloc<PlansOverviewEvent, PlansOverviewState> {
  DateTime monthYear = DateTime.now();

  MonthPickerBloc() : super(PlansOverviewInitial()) {
    on<SetMonthPickerEvent>(_setterPlanOverview);
  }

  void _setterPlanOverview(
    SetMonthPickerEvent event,
    Emitter<PlansOverviewState> emit,
  ) async {
    emit(PlansOverviewInitial());
    monthYear = event.monthYear;
    emit(const PickerMonthSuccess());
  }
}
