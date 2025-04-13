import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:equatable/equatable.dart';

abstract class PlanAllMonthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllPlans extends PlanAllMonthEvent {}

class DeletePlanById extends PlanAllMonthEvent {
  final int planId;

  DeletePlanById({required this.planId});
}

class AddNewPlan extends PlanAllMonthEvent {
  final PlanDto planDto;

  AddNewPlan({required this.planDto});
}
