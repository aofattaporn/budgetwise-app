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

class DeletePlanIteById extends PlanItemEvent {
  final String planItemId;
  final int planId;

  DeletePlanIteById({required this.planItemId, required this.planId});
}
