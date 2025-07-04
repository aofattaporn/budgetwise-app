import 'package:budget_wise/data/models/plan_dto.dart';

abstract class CurrentPlanEvent {}

class FetchCurrentPlanEvent extends CurrentPlanEvent {}

class FetchPlanByIdEvent extends CurrentPlanEvent {
  final String planId;
  FetchPlanByIdEvent({required this.planId});
}

class UpdateNewPlan extends CurrentPlanEvent {
  final PlanDto planDto;
  UpdateNewPlan({required this.planDto});
}

class DeletePlanById extends CurrentPlanEvent {
  final String planId;
  DeletePlanById({required this.planId});
}
