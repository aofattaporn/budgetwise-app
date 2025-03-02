import 'package:budget_wise/src/models/entity/plan.dart';
import 'package:budget_wise/src/models/entity/plan_item.dart';

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
  final Plan planInfo;
  final List<PlanItem> planItems;
  GetPlanCurrentMonthSuccess(this.planInfo, this.planItems);
}

final class GetPlanCurrentMonthEmpty extends PlanState {
  GetPlanCurrentMonthEmpty();
}

final class GetPlanSuccess extends PlanState {
  GetPlanSuccess();
}

final class PlanError extends PlanState {
  final String ex;
  PlanError(this.ex);
}
