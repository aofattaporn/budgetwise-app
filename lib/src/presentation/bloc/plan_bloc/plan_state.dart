import 'package:equatable/equatable.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanLoaded extends PlanState {
  final PlanEntity plan;
  PlanLoaded(this.plan);

  @override
  List<Object?> get props => [plan];
}

class PlanError extends PlanState {
  final String message;
  PlanError(this.message);

  @override
  List<Object?> get props => [message];
}
