import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final double percentage;
  final double amount;

  const ExpenseItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: SizeConstants.kPaddV12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // ignore: deprecated_member_use
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
        ],
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${percentage.toStringAsFixed(0)}%", // Show percentage value
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Amount (€)
          Text(
            "${amount.toStringAsFixed(0)} B",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
