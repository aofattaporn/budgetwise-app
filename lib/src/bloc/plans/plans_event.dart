import 'package:budget_wise/src/data/models/planning_model.dart';

sealed class PlansEvent {}

// event: create account
final class GetPlansEvent extends PlansEvent {
  GetPlansEvent();
}

final class CreatePlanEvent extends PlansEvent {
  final Planning planning;
  CreatePlanEvent({required this.planning});
}
