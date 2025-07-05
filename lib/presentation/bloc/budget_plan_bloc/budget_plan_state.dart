import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetPlanState extends Equatable {
  const BudgetPlanState();
  @override
  List<Object?> get props => [];
}

class BudgetPlanInitial extends BudgetPlanState {}

class BudgetPlanLoading extends BudgetPlanState {}

class BudgetPlanLoaded extends BudgetPlanState {
  final PlanMonthlyBudget planMonthlyBudget;
  const BudgetPlanLoaded({required this.planMonthlyBudget});
}

class BudgetPlanError extends BudgetPlanState {
  final String message;
  const BudgetPlanError(this.message);
  @override
  List<Object?> get props => [message];
}
