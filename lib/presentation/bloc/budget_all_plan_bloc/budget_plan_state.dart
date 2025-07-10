import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:equatable/equatable.dart';

abstract class BudgetAllPlanState extends Equatable {
  const BudgetAllPlanState();
  @override
  List<Object?> get props => [];
}

// =======================================================
// BudgetPlanState common
// =======================================================

class BudgetPlanInitial extends BudgetAllPlanState {}

// =======================================================
// GetAllPlanUsecase
// =======================================================
class GetAllPlanLoading extends BudgetAllPlanState {}

class GetAllPlanLoaded extends BudgetAllPlanState {
  final List<PlanDto> listPlanDto;
  const GetAllPlanLoaded({required this.listPlanDto});
}

class GetAllPlanError extends BudgetAllPlanState {
  final String message;
  const GetAllPlanError(this.message);
  @override
  List<Object?> get props => [message];
}
