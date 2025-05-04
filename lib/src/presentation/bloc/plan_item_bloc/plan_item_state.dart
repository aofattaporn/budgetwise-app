import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

abstract class PlanItemState {}

class PlanItemInitial extends PlanItemState {}

class PlanItemLoading extends PlanItemState {}

class PlanItemLoaded extends PlanItemState {
  final List<PlanItemEntity> planItems;

  PlanItemLoaded(this.planItems);
}

class PlanItemEmpty extends PlanItemState {}

class PlanItemIsOvering extends PlanItemState {
  final String message;
  PlanItemIsOvering(this.message);
}

class PlanItemError extends PlanItemState {
  final String message;
  PlanItemError(this.message);
}
