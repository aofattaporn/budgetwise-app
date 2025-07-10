import 'package:equatable/equatable.dart';

abstract class BudgetAllPlanEvent extends Equatable {
  const BudgetAllPlanEvent();
  @override
  List<Object?> get props => [];
}

class LoadAllBudgetPlan extends BudgetAllPlanEvent {}
