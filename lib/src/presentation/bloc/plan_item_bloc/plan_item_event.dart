import 'package:budget_wise/src/domain/models/plan_item_dto.dart';

abstract class PlanItemEvent {}

class FetchPlanItemEvent extends PlanItemEvent {
  final int planId;

  FetchPlanItemEvent(this.planId);
}

class AddPlanItemEvent extends PlanItemEvent {
  final PlanItemDto planItemDto;

  AddPlanItemEvent({required this.planItemDto});
}

class DeletePlanItemById extends PlanItemEvent {
  final String planItemId;
  final int planId;

  DeletePlanItemById({required this.planItemId, required this.planId});
}

class UpdatePlanItemById extends PlanItemEvent {
  final String planItemId;
  final PlanItemDto planItemDto;

  UpdatePlanItemById({required this.planItemId, required this.planItemDto});
}
