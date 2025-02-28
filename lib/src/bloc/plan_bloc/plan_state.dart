import 'package:budget_wise/src/models/entity/plan.dart';

sealed class PlanState {
  PlanState();
}

// Initial state when nothing has happened yet
final class InitialState extends PlanState {
  InitialState();
}

final class GetPlanCurrentMonthLoading extends PlanState {
  GetPlanCurrentMonthLoading();
}

final class GetPlanCurrentMonthSuccess extends PlanState {
  final Plan planCurrentMonth;
  GetPlanCurrentMonthSuccess(this.planCurrentMonth);
}

final class GetPlanSuccess extends PlanState {
  GetPlanSuccess();
}

final class PlanError extends PlanState {
  final String ex;
  PlanError(this.ex);
}
