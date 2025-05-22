import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemBloc extends Bloc<PlanItemBloc, PlanItemState> {
  PlanItemBloc() : super(PlanItemInitial()) {}
}
