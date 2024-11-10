import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BudgetLimitLabelLoading extends StatelessWidget {
  const BudgetLimitLabelLoading({
    super.key,
  });

  static const double verticalPadding = 18.0;
  static const double textSpacing = 12.0;
  static const double containerHeight = 12.0;
  static const double borderRadiusValue = 10.0;
  static const Color containerColor = Color.fromRGBO(240, 240, 240, 1);
  static const String budgetText = '... / 2000 B';
  static const String mockText = 'Text For Mock Example';

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: verticalPadding),
        child: Column(
          children: [
            Text(budgetText, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: textSpacing),
            const Text(mockText),
            IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                ),
                height: containerHeight,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
