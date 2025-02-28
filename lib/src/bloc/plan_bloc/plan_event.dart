sealed class PlanEvent {
  PlanEvent();
}

final class TabScreenEvent extends PlanEvent {
  final String tabName;
  TabScreenEvent({required this.tabName});
}

final class GetPlanByMonthEvent extends PlanEvent {
  GetPlanByMonthEvent();
}

final class GetAlreadtPlanCurrentMonth extends PlanEvent {
  GetAlreadtPlanCurrentMonth();
}
