import 'package:budget_wise/src/constant/constants.dart';
import 'package:budget_wise/src/presentation/screens/CreateTransaction/create_transactions.dart';
import 'package:flutter/material.dart';

class HorizontalSrollViewOperations extends StatelessWidget {
  const HorizontalSrollViewOperations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Operations"),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          child: Row(
            children: [
              for (int index = 0;
                  index < Constants.operations.length;
                  index++) ...[
                Column(
                  children: [
                    Container(
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
                                    return CreateTransacction(
                                        operation: Constants.operations[index]);
                                  },
                                );
                              },
                              icon: Constants.operations[index].icon),
                        )),
                    const SizedBox(height: 4),
                    Text(Constants.operations[index].name)
                  ],
                ),
                if (index < Constants.operations.length - 1)
                  const SizedBox(width: 25),
              ],
            ],
          ),
        )
      ],
    );
  }
}
