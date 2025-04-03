import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:flutter/material.dart';

class AmountCompare extends StatelessWidget {
  final double usage;
  final double limitAmount;
  final bool isLarge;
  const AmountCompare(
      {super.key,
      required this.usage,
      required this.limitAmount,
      this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: NumberUtil.formatAmount(usage),
            style: isLarge
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.labelLarge,
          ),
          TextSpan(
            text: ' /${NumberUtil.formatAmount(limitAmount)} B',
            style: isLarge
                ? Theme.of(context).textTheme.labelMedium
                : Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
