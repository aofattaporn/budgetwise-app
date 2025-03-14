import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:flutter/material.dart';

class AmountCompare extends StatelessWidget {
  final double usage;
  final double limitAmount;
  const AmountCompare(
      {super.key, required this.usage, required this.limitAmount});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: NumberUtil.formatAmount(usage),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          TextSpan(
            text: ' /${NumberUtil.formatAmount(limitAmount)} B',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
