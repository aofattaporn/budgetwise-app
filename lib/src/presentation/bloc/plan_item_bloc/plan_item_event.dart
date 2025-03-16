abstract class PlanItemEvent {}

class FetchPlanItemEvent extends PlanItemEvent {
  final int planId;

  FetchPlanItemEvent(this.planId);
}
