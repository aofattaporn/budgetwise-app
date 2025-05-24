import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/src/domain/models/plan_item_insert_dto.dart';

abstract class PlanItemEvent {}

class FetchPlanItems extends PlanItemEvent {
  final String planId;
  FetchPlanItems(this.planId);
}

class ResetPlanItemEmpty extends PlanItemEvent {
  ResetPlanItemEmpty();
}

class CreatePlanItem extends PlanItemEvent {
  final PlanItemInsertDto item;
  CreatePlanItem(this.item);
}

class UpdatePlanItem extends PlanItemEvent {
  final PlanItemEntity item;
  UpdatePlanItem(this.item);
}

class DeletePlanItem extends PlanItemEvent {
  final String itemId;
  DeletePlanItem(this.itemId);
}

class SelectPlanItem extends PlanItemEvent {
  final String itemId;
  SelectPlanItem(this.itemId);
}
