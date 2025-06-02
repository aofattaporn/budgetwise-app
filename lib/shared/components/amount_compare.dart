import 'package:budget_wise/shared/theme/system/app_text_style.dart';
import 'package:budget_wise/core/utils/numbers_uti.dart';
import 'package:flutter/material.dart';

class AmountCompare extends StatelessWidget {
  final double usage;
  final double limitAmount;
  final bool isLarge;
  const AmountCompare({
    super.key,
    this.isLarge = false,
    required this.usage,
    required this.limitAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: NumberUtil.formatAmount(usage),
            style: isLarge
                ? AppTextStyles.headlineMedium
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
