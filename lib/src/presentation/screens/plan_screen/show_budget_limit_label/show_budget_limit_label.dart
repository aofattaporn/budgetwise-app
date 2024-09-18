import 'package:budget_wise/src/bloc/users/users_bloc.dart';
import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetLimitLabel extends StatelessWidget {
  final double salary;

  const BudgetLimitLabel({
    required this.salary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
              child: Text('... / ${salary} B',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
          SizedBox(height: 12),
          Text("Date for Reset Budget plan 1 June 2024"),
          IntrinsicWidth(
              child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(240, 240, 240, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 12,
            width: MediaQuery.sizeOf(context).width,
          ))
        ],
      ),
    );
  }
}
