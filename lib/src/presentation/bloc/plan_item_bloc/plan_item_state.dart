import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

abstract class PlanItemState {}

class PlanItemInitial extends PlanItemState {}

class PlanItemLoading extends PlanItemState {}

class PlanItemLoaded extends PlanItemState {
  final List<PlanItemEntity> items;
  PlanItemLoaded(this.items);
}

class PlanItemError extends PlanItemState {
  final String message;
  PlanItemError(this.message);
}

class PlanItemSelected extends PlanItemState {
  final String selectedId;
  PlanItemSelected(this.selectedId);
}
