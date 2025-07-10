import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetPlanState extends Equatable {
  const BudgetPlanState();
  @override
  List<Object?> get props => [];
}

// =======================================================
// BudgetPlanState common
// =======================================================

class BudgetPlanInitial extends BudgetPlanState {}

// =======================================================
// GetPlanMonthlyUsecase
// =======================================================
class BudgetPlanLoading extends BudgetPlanState {}

class BudgetPlanLoaded extends BudgetPlanState {
  final PlanMonthlyBudget planMonthlyBudget;
  const BudgetPlanLoaded({required this.planMonthlyBudget});
}

class BudgetPlanEmpty extends BudgetPlanState {
  final String message;
  const BudgetPlanEmpty(this.message);
  @override
  List<Object?> get props => [message];
}

class BudgetPlanError extends BudgetPlanState {
  final String message;
  const BudgetPlanError(this.message);
  @override
  List<Object?> get props => [message];
}

// =======================================================
// GetAllPlanUsecase
// =======================================================
class GetAllPlanLoading extends BudgetPlanState {}

class GetAllPlanLoaded extends BudgetPlanState {
  final List<PlanDto> listPlanDto;
  const GetAllPlanLoaded({required this.listPlanDto});
}

class GetAllPlanError extends BudgetPlanState {
  final String message;
  const GetAllPlanError(this.message);
  @override
  List<Object?> get props => [message];
}
