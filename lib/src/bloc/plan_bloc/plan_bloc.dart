import 'package:budget_wise/src/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final database = Supabase.instance.client.from('plan_items');

  PlanBloc() : super(InitialState()) {
    on<GetPlanByMonthEvent>(_getPlanByMonth);
  }

  void _getPlanByMonth(
    GetPlanByMonthEvent event,
    Emitter<PlanState> emit,
  ) async {
    final response = await database.select();
    print('Response: ${response.length}');

    emit(GetPlanSuccess());
  }
}
