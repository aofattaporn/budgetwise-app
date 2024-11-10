import 'package:budget_wise/src/presentation/screens/plan_screen/%5Btoast%5D_salary_input_dialog/salary_input_dialog.dart';
import 'package:flutter/material.dart';

class BudgetMonthYearNotFound extends StatelessWidget {
  final Widget? widget;
  final String errorMessage;
  final DateTime monthYear;
  final void Function(DateTime)? onDateSelected;

  const BudgetMonthYearNotFound(
      {super.key,
      this.widget,
      required this.errorMessage,
      required this.monthYear,
      required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => SalaryInputDialog.show(context, monthYear),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.redAccent,
                height: 2.1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          widget ?? Container(),
        ],
      ),
    );
  }
}
