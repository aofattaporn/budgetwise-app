import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/numbers_uti.dart';
import 'package:budget_wise/src/utils/strings_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  void _chooseDate(BuildContext context) async {
    DateTime? selectedDate;
    DateTime tempPickedDate = monthYear;
    selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  initialDateTime: monthYear,
                  minimumDate: DateTime(2000),
                  maximumDate: DateTime(2101),
                  onDateTimeChanged: (DateTime newDate) {
                    tempPickedDate = newDate;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop(tempPickedDate);
                },
              ),
            ],
          ),
        );
      },
    );
    if (selectedDate != null) {
      onDateSelected?.call(selectedDate);
    }
  }

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
        const Text('Month for Budget plan: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            )),
        GestureDetector(
          onTap: () => _chooseDate(context),
          child: Text(
            DateFormat('MMMM yyyy').format(monthYear),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
