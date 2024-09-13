import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/presentation/screens/create_transaction/create_transactions.dart';
import 'package:flutter/material.dart';

class OperationAction extends StatelessWidget {
  const OperationAction({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 50,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Center(
          child: IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return CreateTransaction(
                        operation: Constants.operations[index]);
                  },
                );
              },
              icon: Constants.operations[index].icon),
        ));
  }
}
