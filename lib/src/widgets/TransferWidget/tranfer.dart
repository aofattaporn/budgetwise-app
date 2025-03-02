import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final double percentage;
  final double usage;
  final double amount;

  const ExpenseItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.amount,
    required this.usage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: SizeConstants.kPaddV12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Circular Percentage Indicator
          CircularPercentIndicator(
            radius: 25.0,
            lineWidth: 4.0,
            percent: percentage / 100, // Convert percentage to 0-1
            center: const Icon(Icons.shopping_bag,
                size: 20, color: Colors.black54), // Change icon as needed
            progressColor: ColorConstants.primarySubtle,
            backgroundColor: Colors.grey.shade100,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 16), // Spacing between icon and text

          // Text Column (Category Name & Percentage)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.size16w600,
                ),
                Text(
                  "${percentage.toStringAsFixed(0)}%",
                  style: TextStyles.size12w400,
                ),
              ],
            ),
          ),

          // Amount (€)
          AmountCompare(usage: usage, amount: amount),
        ],
      ),
    );
  }
}
