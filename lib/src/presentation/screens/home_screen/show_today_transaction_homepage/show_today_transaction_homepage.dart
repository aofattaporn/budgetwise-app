import 'package:budget_wise/src/presentation/widgets/transaction_item/transacction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowTodayTransactionHomepage extends StatelessWidget {
  const ShowTodayTransactionHomepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today Transactions"),
        SizedBox(height: 16),

        // TODO : handler height of list item
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
