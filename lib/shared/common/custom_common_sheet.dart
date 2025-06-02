// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/shared/sheets/option_plan_item_sheet.dart';
import 'package:budget_wise/shared/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCommonSheet {
  // ** defuat static properties **
  static const double defaultHeight = 0.6;
  static const double defaultRadius = 16;
  static const bool defaultEnabledScroll = true;

  final double? height;
  final double radius;
  final bool enabledScroll;

  CustomCommonSheet({
    this.enabledScroll = defaultEnabledScroll,
    this.radius = defaultRadius,
    this.height = defaultHeight,
  });

  // void allPlansSheet(BuildContext context, {int? planIdSelected}) {
  //   _commonSheet(
  //       context,
  //       PlanningOverviewSheet(
  //         planIdSelected: planIdSelected,
  //       ));
  // }

  // void createNewPlanItem(BuildContext context,
  //     {required int planId, PlanItemDto? planItemDto, String? id}) {
  //   _commonSheet(
  //       context,
  //       CreateNewPlanItemSheet(
  //         planId: planId,
  //         id: id,
  //         planItemDto: planItemDto,
  //       ));
  // }

  void open(BuildContext context, {required Widget widget}) {
    _commonSheet(context, widget);
  }

  void optionPlanItemSheet(
    BuildContext context, {
    required Function(BuildContext context) onEdit,
    required Function(BuildContext context) onDelete,
  }) {
    _commonSheet(
        context,
        OptionPlanItemSheet(
          onEdit: onEdit,
          onDelete: onDelete,
        ));
  }

  void _commonSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      builder: (context) {
        return SizedBox(
          height: height != null
              ? MediaQuery.of(context).size.height * height!
              : null,
          child: widget,
        );
      },
    );
  }
}
