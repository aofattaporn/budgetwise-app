import 'package:budget_wise/src/presentation/constant/textstyle.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/month_year_picker/month_year_picker.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/salary_input_dialog/salary_input_dialog.dart';
import 'package:budget_wise/src/utils/datetime_util.dart';
import 'package:flutter/material.dart';

class BudgetMonthYearNotFound extends StatelessWidget {
  final String errorMessage;
  final DateTime monthYear;
  final void Function(DateTime)? onDateSelected;

  const BudgetMonthYearNotFound(
      {super.key,
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
          _displayMonthUsageAndSelectMonth(context),
        ],
      ),
    );
  }

  /// A private method that creates a `Row` widget to display the current month's usage
  /// and allows the user to select a different month.
  ///
  /// The method takes a `BuildContext` as a parameter to access the context of the widget tree.
  ///
  /// - Parameter context: The `BuildContext` of the widget tree.
  Row _displayMonthUsageAndSelectMonth(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Month for Budget plan: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            )),
        GestureDetector(
          onTap: () => MonthYearPickerBuilder()
              .setInitialDate(monthYear)
              .setOnDateSelected(onDateSelected!)
              .build()
              .chooseDate(context),
          child: TextValue()
              .withText(UtilsDateTime.monthYearFormat(monthYear))
              .getFont14BoldBlack()
              .build(),
        ),
      ],
    );
  }
}
