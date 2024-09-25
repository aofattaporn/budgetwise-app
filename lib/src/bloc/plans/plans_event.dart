import 'package:budget_wise/src/data/models/planning_model.dart';

sealed class PlansEvent {}

// event: create account
final class GetPlansEvent extends PlansEvent {
  GetPlansEvent();
}

final class GetCurrentSpendingEvent extends PlansEvent {
  GetCurrentSpendingEvent();
}

final class CreatePlanEvent extends PlansEvent {
  final Planning planning;
  CreatePlanEvent({required this.planning});
}

final class UpdatePlanEvent extends PlansEvent {
  final Planning planning;
  UpdatePlanEvent({required this.planning});
}

final class DeletePlanEvent extends PlansEvent {
  final int planId;
  DeletePlanEvent({required this.planId});
}
