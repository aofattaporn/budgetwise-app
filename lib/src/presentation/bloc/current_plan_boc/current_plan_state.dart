import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class CurrentPlanState {}

class CurrentPlanInitial extends CurrentPlanState {}

class CurrentPlanLoading extends CurrentPlanState {}

class CurrentPlanLoaded extends CurrentPlanState {
  final PlanEntity plan;
  CurrentPlanLoaded(this.plan);
}

class CurrentPlanEmpty extends CurrentPlanState {}

class CurrentPlanError extends CurrentPlanState {
  final String message;
  CurrentPlanError(this.message);
}
