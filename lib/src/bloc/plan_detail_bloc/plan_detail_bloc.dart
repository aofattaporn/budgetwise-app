import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_event.dart';
import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanDetailBloc extends Bloc<PlanDetailEvent, PlanDetailState> {
  PlanDetailBloc()
      : super(PlanDetailInitial(
            startDate: null,
            endDate: null,
            amount: TextEditingController(text: '0'))) {
    on<InitializePlanningDetailEvent>((event, emit) {
      emit(PlanUpdatedState(
        startDate: event.startDate,
        endDate: event.endDate,
        amount: event.amount,
      ));
    });

    on<UpdateStartDateEvent>((event, emit) {
      if (state is PlanUpdatedState) {
        emit(PlanUpdatedState(
          startDate: event.newDate,
          endDate: (state as PlanUpdatedState).endDate,
          amount: (state as PlanUpdatedState).amount,
        ));
      }
    });

    on<UpdateEndDateEvent>((event, emit) {
      if (state is PlanUpdatedState) {
        emit(PlanUpdatedState(
          startDate: (state as PlanUpdatedState).startDate,
          endDate: event.newDate,
          amount: (state as PlanUpdatedState).amount,
        ));
      }
    });

    on<UpdateAmountEvent>((event, emit) {
      if (state is PlanUpdatedState) {
        emit(PlanUpdatedState(
          startDate: (state as PlanUpdatedState).startDate,
          endDate: (state as PlanUpdatedState).endDate,
          amount: event.amount,
        ));
      }
    });

    on<SavePlanningEvent>((event, emit) {
      print("Planning saved!");
    });
  }
}
