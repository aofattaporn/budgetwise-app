import 'package:budget_wise/src/models/entity/plan_item.dart';

sealed class PlanItemsState {
  PlanItemsState();
}

// Initial state when nothing has happened yet
final class InitialState extends PlanItemsState {
  InitialState();
}

final class GetPlanItemsCurrentMonthLoading extends PlanItemsState {
  GetPlanItemsCurrentMonthLoading();
}

final class GetPlanItemsCurrentMonthSuccess extends PlanItemsState {
  final List<PlanItem> planItem;
  GetPlanItemsCurrentMonthSuccess(this.planItem);
}

final class PlanItemsError extends PlanItemsState {
  final String ex;
  PlanItemsError(this.ex);
}
