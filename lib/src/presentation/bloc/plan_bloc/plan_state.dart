import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanState {}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanLoaded extends PlanState {
  final PlanEntity plan;
  PlanLoaded(this.plan);
}

class AllPlanLoaded extends PlanState {
  final List<PlanEntity> planList;
  AllPlanLoaded(this.planList);
}

class PlanEmpty extends PlanState {}

class PlanError extends PlanState {
  final String message;
  PlanError(this.message);
}
