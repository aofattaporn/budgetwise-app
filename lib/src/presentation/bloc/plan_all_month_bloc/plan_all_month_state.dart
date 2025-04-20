import 'package:equatable/equatable.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanAllMonthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlanAllMonthInitial extends PlanAllMonthState {}

class PlanLoaded extends PlanAllMonthState {
  final PlanEntity plan;
  PlanLoaded(this.plan);
}

class AllPlanLoading extends PlanAllMonthState {}

class CreatePlanSuccess extends PlanAllMonthState {}

class EditPlanSuccess extends PlanAllMonthState {}

class DeletePlanSuccess extends PlanAllMonthState {}

class AllPlanLoaded extends PlanAllMonthState {
  final List<PlanEntity> plans;
  AllPlanLoaded({required this.plans});
}

class PlanAllMonthError extends PlanAllMonthState {
  final String message;
  PlanAllMonthError(this.message);
}
