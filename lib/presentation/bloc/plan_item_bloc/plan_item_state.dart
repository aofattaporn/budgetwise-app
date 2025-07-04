import 'package:budget_wise/data/models/plan_item_dto.dart';

abstract class PlanItemState {}

class PlanItemInitial extends PlanItemState {}

class PlanItemLoading extends PlanItemState {}

class PlanItemLoaded extends PlanItemState {
  final List<PlanItemDto> items;
  PlanItemLoaded(this.items);
}

class PlanItemResetAlreadyEmpty extends PlanItemState {
  final List<PlanItemDto> items;
  PlanItemResetAlreadyEmpty(this.items);
}

class PlanItemError extends PlanItemState {
  final String message;
  PlanItemError(this.message);
}

class PlanItemSelected extends PlanItemState {
  final String selectedId;
  PlanItemSelected(this.selectedId);
}

class PlanItemOperationFailed extends PlanItemState {
  final String message;
  PlanItemOperationFailed(this.message);
}
