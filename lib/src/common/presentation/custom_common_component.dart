import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/screens/components/plan_item_component.dart';
import 'package:flutter/cupertino.dart';

class CustomCommonComponent {
  static Widget planItemComponent(PlanEntity planEntity,
      {int? selectedId, bool? isEditing}) {
    return PlanItemComponent(
      planEntity: planEntity,
      selectedId: selectedId,
      idEditing: isEditing,
    );
  }
}
