import 'package:budget_wise/src/presentation/widgets/Transaction/TransactionItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerticalScrollViewTodayTransaction extends StatelessWidget {
  const VerticalScrollViewTodayTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today Transactions"),
        SizedBox(height: 16),

        // add list view avoid over flow
        SizedBox(
          height: 225,
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => TransactionItem()),
        ),
      ],
    );
  }
}
