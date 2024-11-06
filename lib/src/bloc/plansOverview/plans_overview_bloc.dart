// pls to write lboc

import 'package:budget_wise/src/bloc/plansOverview/plans_overview_event.dart';
import 'package:budget_wise/src/bloc/plansOverview/plans_overview_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansOverviewBloc extends Bloc<PlansOverviewEvent, PlansOverviewState> {
  PlansOverviewBloc() : super(PlansOverviewInitial()) {
    on<PlansOverviewEvent>((event, emit) async {});
  }

  @override
  Stream<PlansOverviewState> mapEventToState(PlansOverviewEvent event) async* {
    // TODO: implement event handler
  }

  void onGetPlans(
    LoadPlans event,
    Emitter<PlansOverviewState> emit,
  ) async {
    emit(PlansOverviewLoading());
  }
}
