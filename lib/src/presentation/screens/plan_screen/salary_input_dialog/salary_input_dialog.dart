import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalaryInputDialog {
  static void show(BuildContext context, DateTime monthYear) {
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
}
