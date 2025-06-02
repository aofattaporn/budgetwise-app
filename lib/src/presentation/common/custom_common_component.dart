import 'package:budget_wise/features/plan/domain/entities/plan_entity.dart';
import 'package:budget_wise/features/plan/data/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/components/labeled_date_picker_row.dart';
import 'package:budget_wise/src/presentation/components/labeled_icon_row.dart';
import 'package:budget_wise/src/presentation/components/labeled_textfield_row.dart';
import 'package:budget_wise/src/presentation/components/plan/plan_budget_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCommonComponent {
  // ======================================================
  //  COMMON COMPONENTS
  // ======================================================
  static Widget labelledTextFieldRow({
    // * require paramm *
    required TextEditingController textEditingController,
    required String label,
    // * not-require paramm *
    String placeHolder = "",
    bool isNumberOnly = false,
  }) {
    return LabelledTextFieldRow(
      label: label,
      textEditingController: textEditingController,
      placeholder: placeHolder,
      isNumberOnly: isNumberOnly,
    );
  }

  static Widget labeledDatePickerRow({
    // * require paramm *
    required TextEditingController textEditingController,
    required String label,
    // * not-require paramm *
    String placeHolder = "",
    bool isNumberOnly = false,
  }) {
    return LabeledDatePickerRow(
      label: label,
      textEditingController: textEditingController,
      placeholder: placeHolder,
    );
  }

  static Widget labelledIconRow(
      {
      // * require paramm *
      required String iconData,
      required Function(String) handleSelectIcon
      // * not-require paramm *
      }) {
    return LabeledIconRow(
      iconData: iconData,
      handleSelectIcon: handleSelectIcon,
    );
  }

  // ======================================================
  //  COMMON COMPONENTS
  // ======================================================
  static Widget planBudgetCard({
    // * require paramm *
    required PlanDto plan,
    // * not-require paramm *
    String? selectedPlanId,
  }) {
    return PlanBudgetCard(
      plans: plan,
      selectedPlanId: selectedPlanId,
    );
  }
}
