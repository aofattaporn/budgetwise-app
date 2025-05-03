import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/presentation/components/labeled_icon_row.dart';
import 'package:budget_wise/src/presentation/components/labelled_textfield_row.dart';
import 'package:budget_wise/src/presentation/components/plan_item_card.dart';
import 'package:budget_wise/src/presentation/components/plan_item_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCommonComponent {
  static Widget planItemComponent(PlanEntity planEntity,
      {int? selectedId, bool? isEditing}) {
    return PlanItemComponent(
      planEntity: planEntity,
      selectedId: selectedId,
      idEditing: isEditing,
    );
  }

  static Widget planItemCard({
    // require paramm
    required PlanItemEntity planEntity,
    required double progress,
    // not-require paramm
  }) {
    return PlanItemCard(
      item: planEntity,
      progress: progress,
    );
  }

  static Widget labelledTextFieldRow({
    // require paramm
    required TextEditingController textEditingController,
    required String label,
    // not-require paramm
    String placeHolder = "",
  }) {
    return LabelledTextFieldRow(
      label: label,
      textEditingController: textEditingController,
      placeholder: placeHolder,
    );
  }

  static Widget labelledIconRow(
      {
      // require paramm
      required String iconData,
      required Function(String) handleSelectIcon
      // not-require paramm
      }) {
    return LabeledIconRow(
      iconData: iconData,
      handleSelectIcon: handleSelectIcon,
    );
  }
}
