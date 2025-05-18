import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanSelectorState {}

class PlanAllInitial extends PlanSelectorState {}

class NotFoundAnyPlans extends PlanSelectorState {}

class PlanAllLoading extends PlanSelectorState {}

class AllPlanLoaded extends PlanSelectorState {
  final List<PlanEntity> planList;
  AllPlanLoaded(this.planList);
}

class PlanAllError extends PlanSelectorState {
  final String message;
  PlanAllError(this.message);
}
