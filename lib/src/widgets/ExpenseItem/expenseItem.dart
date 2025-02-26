import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final double percentage;
  final double amount;

  const ExpenseItem({
    required this.title,
    required this.percentage,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          // Circular Percentage Indicator
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 6.0,
            percent: percentage / 100, // Convert percentage to 0-1
            center: Icon(Icons.shopping_bag,
                size: 20, color: Colors.black54), // Change icon as needed
            progressColor: Colors.redAccent,
            backgroundColor: Colors.redAccent.shade100,
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
            "€${amount.toStringAsFixed(0)}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
