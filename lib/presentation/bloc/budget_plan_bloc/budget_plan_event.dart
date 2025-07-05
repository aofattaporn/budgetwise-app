import 'package:equatable/equatable.dart';

abstract class BudgetPlanEvent extends Equatable {
  const BudgetPlanEvent();
  @override
  List<Object?> get props => [];
}

class LoadBudgetPlan extends BudgetPlanEvent {}
