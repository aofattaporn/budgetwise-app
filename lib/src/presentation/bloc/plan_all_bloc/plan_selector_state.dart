import 'package:budget_wise/features/plan/data/models/plan_dto.dart';

abstract class PlanSelectorState {}

class PlanAllInitial extends PlanSelectorState {}

class NotFoundAnyPlans extends PlanSelectorState {}

class PlanAllLoading extends PlanSelectorState {}

class AllPlanLoaded extends PlanSelectorState {
  final List<PlanDto> planList;
  AllPlanLoaded(this.planList);
}

class PlanAllError extends PlanSelectorState {
  final String message;
  PlanAllError(this.message);
}
