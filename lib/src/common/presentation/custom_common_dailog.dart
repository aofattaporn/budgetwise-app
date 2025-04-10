import 'package:budget_wise/src/presentation/screens/sheets/planning_overview_sheet.dart';
import 'package:flutter/material.dart';

class CustomCommonDialog {
  // Default static properties
  static const double defaultWidthFactor = 0.8;
  static const double defaultRadius = 16;

  final double widthFactor;
  final double radius;

  CustomCommonDialog({
    this.widthFactor = defaultWidthFactor,
    this.radius = defaultRadius,
  });

  void allPlansDialog(BuildContext context, int planIdSelected) {
    _showCommonDialog(
      context,
      PlanningOverviewSheet(planIdSelected: planIdSelected),
    );
  }

  void _showCommonDialog(BuildContext context, Widget child) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: child,
          ),
        );
      },
    );
  }
}
