import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanAllState {}

class PlanAllInitial extends PlanAllState {}

class PlanAllLoading extends PlanAllState {}

class AllPlanLoaded extends PlanAllState {
  final List<PlanEntity> planList;
  AllPlanLoaded(this.planList);
}

class PlanAllError extends PlanAllState {
  final String message;
  PlanAllError(this.message);
}
