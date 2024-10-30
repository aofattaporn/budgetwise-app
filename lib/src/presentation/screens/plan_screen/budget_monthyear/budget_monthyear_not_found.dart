import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BudgetMonthYearNotFound extends StatelessWidget {
  final String errorMessage;
  final DateTime monthYear;
  final void Function(DateTime)? onDateSelected;

  const BudgetMonthYearNotFound(
      {super.key,
      required this.errorMessage,
      required this.monthYear,
      required this.onDateSelected});

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

  void _showSalaryInputDialog(BuildContext context) {
    final TextEditingController salaryController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Salary'),
          content: Column(
            children: [
              const Text('Please enter your salary'),
              GenericInputField(
                controller: salaryController,
                isOnlyNumber: true,
                hintText: 'Enter salary',
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Submit'),
              onPressed: () {
                final String salary = salaryController.text;
                context.read<UsersFinBloc>().add(AddSalaryByMonthEvent(
                    balance: double.parse(salary), monthYear: monthYear));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showSalaryInputDialog(context),
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
