import 'package:budget_wise/data/models/plan_dto.dart';

abstract class CurrentPlanState {}

class CurrentPlanInitial extends CurrentPlanState {}

class CurrentPlanLoading extends CurrentPlanState {}

class CurrentPlanDeleted extends CurrentPlanState {}

class CurrentPlanLoaded extends CurrentPlanState {
  final PlanDto plan;
  CurrentPlanLoaded(this.plan);
}

class CurrentPlanEmpty extends CurrentPlanState {}

class CurrentPlanError extends CurrentPlanState {
  final String message;
  CurrentPlanError(this.message);
}
