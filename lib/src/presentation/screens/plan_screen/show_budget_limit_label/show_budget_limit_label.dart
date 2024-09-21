import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/Numbers.dart';
import 'package:budget_wise/src/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetLimitLabel extends StatelessWidget {
  final double currentUsage;
  final double limitBudgetPlan;
  final double? predictionAmount;
  final DateTime dateReset;

  const BudgetLimitLabel({
    required this.currentUsage,
    required this.limitBudgetPlan,
    required this.dateReset,
    this.predictionAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
            child: Text.rich(
              TextSpan(
                text: '${Strings.normalizeNumber(currentUsage.toString())}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '/ ${Strings.normalizeNumber(limitBudgetPlan.toString())} B',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: 'Date for Reset Budget plan: ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${DateFormat('dd MMM yyyy').format(dateReset)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ProgressBar(
            // convert percentage -> normalize [0, 1]
            progress:
                Numbers.calPercentage(currentUsage, limitBudgetPlan) / 100,
            isFullSize: true,
            predicProgress: predictionAmount != null
                ? Numbers.calPercentage(predictionAmount!, limitBudgetPlan) /
                    100
                : null,
          )
        ],
      ),
    );
  }
}
