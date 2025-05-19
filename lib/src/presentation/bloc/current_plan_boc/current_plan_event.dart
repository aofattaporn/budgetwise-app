abstract class CurrentPlanEvent {}

class FetchCurrentPlanEvent extends CurrentPlanEvent {}

class FetchPlanByIdEvent extends CurrentPlanEvent {
  final String planId;
  FetchPlanByIdEvent({required this.planId});
}

class DeletePlanById extends CurrentPlanEvent {
  final String planId;
  DeletePlanById({required this.planId});
}
