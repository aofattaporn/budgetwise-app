import 'package:budget_wise/src/core/constant/common_constant.dart';
import 'package:budget_wise/src/presentation/sheets/planning_overview_sheet.dart';
import 'package:flutter/cupertino.dart';
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

  // void allPlansDialog(BuildContext context, int planIdSelected) {
  //   _showCommonDialog(
  //     context,
  //     PlanningOverviewSheet(planIdSelected: planIdSelected),
  //   );
  // }

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

  void confirmDeleteDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
              child: const Text(CommonConstant.cancelLabel),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              isDestructiveAction: true,
              child: const Text(CommonConstant.deleteLabel),
            ),
          ],
        );
      },
    );
  }
}
