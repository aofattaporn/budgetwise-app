import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/presentation/widgets/operation_action/operation_action.dart';
import 'package:flutter/material.dart';

class ShowOperationsHomepage extends StatelessWidget {
  const ShowOperationsHomepage({
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
                    OperationAction(index: index),
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
