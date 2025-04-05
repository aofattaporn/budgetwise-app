import 'package:budget_wise/src/presentation/screens/sheets/sheet_all_plan.dart';
import 'package:flutter/material.dart';

class CustomCommonSheet {
  // ** defuat static properties **
  static const double defaultHeight = 0.6;
  static const double defaultRadius = 16;
  static const bool defaultEnabledScroll = true;

  final double height;
  final double radius;
  final bool enabledScroll;

  CustomCommonSheet({
    this.enabledScroll = defaultEnabledScroll,
    this.radius = defaultRadius,
    this.height = defaultHeight,
  });

  void allPlansSheet(BuildContext context, int planIdSelected) {
    _commonSheet(
        context,
        SheetAllPlan(
          planIdSelected: planIdSelected,
        ));
  }

  void _commonSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * height,
          child: widget,
        );
      },
    );
  }
}
