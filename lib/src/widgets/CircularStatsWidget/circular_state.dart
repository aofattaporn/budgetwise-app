import 'package:budget_wise/src/constant/date_constant.dart';
import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CircularStatsWidget extends StatelessWidget {
  final bool isLoanding;

  final DateTime startDate;
  final DateTime endDate;
  final double usage;
  final double amount;
  final double percentage;
  final bool enableChangeMonth;

  const CircularStatsWidget({
    super.key,
    required this.isLoanding,
    required this.startDate,
    required this.endDate,
    required this.usage,
    required this.amount,
    required this.percentage,
    required this.enableChangeMonth,
  });

  String getFormattedDateRange() {
    final dateFormat = DateFormat(DateConstant.dateMonthFormat);
    return "${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}";
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoanding,
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: SizeConstants.kRadius12),
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
                  style: !enableChangeMonth
                      ? TextStyles.size12w200
                      : TextStyles.size12w800Primary,
                ),
                const SizedBox(height: SizeConstants.kSize4),
                AmountCompare(usage: usage, amount: amount),
                const SizedBox(height: SizeConstants.kSize10),
                Text(
                  "${percentage.toStringAsFixed(2)}%",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
