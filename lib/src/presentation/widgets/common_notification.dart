import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class CommonNotification {
  /// Show an error as a SnackBar
  static void showSnackBar(BuildContext context, String message,
      {int durationInSeconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  /// Show an error as an AlertDialog
  static void showErrorDialog(
      BuildContext context, String title, String message,
      {int durationInSeconds = 3}) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: durationInSeconds), () {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop(); // Auto close dialog
          }
        });

        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(); // Close manually
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Show an error as a BottomSheet
  static void showBottomSheet(
      BuildContext context, String title, String message,
      {int durationInSeconds = 3}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: durationInSeconds), () {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop(); // Auto close bottom sheet
          }
        });

        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(message),
            ],
          ),
        );
      },
    );
  }
}
