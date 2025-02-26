import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class CircularStatsWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final double usage;
  final double amount;
  final double percentage;

  const CircularStatsWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.usage,
    required this.amount,
    required this.percentage,
  });

  String getFormattedDateRange() {
    final dateFormat = DateFormat("dd MMM");
    return "${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: SizeConstants.kPadd15,
        child: CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 10.0,
          percent: percentage / 100,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: ColorConstants.primary,
          backgroundColor: Colors.grey.shade100,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getFormattedDateRange(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              AmountCompare(usage: usage, amount: amount),
              const SizedBox(height: 10),
              Text(
                "${percentage.toStringAsFixed(2)}%",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
