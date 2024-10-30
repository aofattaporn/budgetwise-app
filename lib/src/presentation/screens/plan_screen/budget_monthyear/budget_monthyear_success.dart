import 'package:budget_wise/src/presentation/constant/textstyle.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/month_year_picker/month_year_picker.dart';
import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/datetime_util.dart';
import 'package:budget_wise/src/utils/numbers_uti.dart';
import 'package:budget_wise/src/utils/strings_util.dart';
import 'package:flutter/material.dart';

class BudgetLimitLabel extends StatelessWidget {
  // add function to choose date
  final double currentUsage;
  final double limitBudgetPlan;
  final double? predictionAmount;
  final DateTime monthYear;
  final void Function(DateTime)? onDateSelected;

  const BudgetLimitLabel({
    required this.currentUsage,
    required this.limitBudgetPlan,
    required this.monthYear,
    this.onDateSelected,
    this.predictionAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          _displayUsageSalary(),
          const SizedBox(height: 12),
          _displayMonthUsageAndSelectMonth(context),
          ProgressBar(
            // convert percentage -> normalize [0, 1]
            progress:
                Numbers.calPercentage(currentUsage, limitBudgetPlan) / 100,
            isFullSize: true,
            predicProgress: predictionAmount != null
                ? Numbers.calPercentage(predictionAmount!, limitBudgetPlan) /
                    100
                : null,
          )
        ],
      ),
    );
  }

  /// Displays the usage salary as a `Text` widget.
  ///
  /// This method returns a `Text` widget that shows the current usage of the salary.
  ///
  /// Returns:
  ///   A `Text` widget displaying the usage salary.
  Text _displayUsageSalary() {
    return Text.rich(
      TextSpan(
        text: Strings.normalizeNumber(currentUsage.toString()),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '/ ${Strings.normalizeNumber(limitBudgetPlan.toString())} B',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
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
        TextValue()
            .withText('Month for Budget plan:  ')
            .getFont12Black()
            .build(),
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
