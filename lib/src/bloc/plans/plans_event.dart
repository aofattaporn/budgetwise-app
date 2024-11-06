import 'package:budget_wise/src/models/entity/planning_entity.dart';

sealed class PlansEvent {}

// event: create account
final class GetPlansEvent extends PlansEvent {
  final String monthYear;
  GetPlansEvent({required this.monthYear});
}

final class GetCurrentSpendingEvent extends PlansEvent {
  GetCurrentSpendingEvent();
}

final class CreatePlanEvent extends PlansEvent {
  final PlanEntity planning;
  CreatePlanEvent({required this.planning});
}

final class UpdatePlanEvent extends PlansEvent {
  final PlanEntity planning;
  UpdatePlanEvent({required this.planning});
}

final class DeletePlanEvent extends PlansEvent {
  final int planId;
  DeletePlanEvent({required this.planId});
}
