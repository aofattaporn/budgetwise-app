sealed class PlanState {
  PlanState();
}

// Initial state when nothing has happened yet
final class InitialState extends PlanState {
  InitialState();
}

final class GetPlanSuccess extends PlanState {
  GetPlanSuccess();
}

final class ErrorState extends PlanState {
  ErrorState();
}
