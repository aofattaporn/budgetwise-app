import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularStatsWidgetEmpty extends StatelessWidget {
  final bool enableChangeMonth;

  const CircularStatsWidgetEmpty({
    super.key,
    required this.enableChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: SizeConstants.kRadius12),
        padding: SizeConstants.kPadd15,
        child: CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 10.0,
          percent: 0 / 100,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: ColorConstants.primary,
          backgroundColor: Colors.grey.shade100,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No plan",
                style: !enableChangeMonth
                    ? TextStyles.size12w600
                    : TextStyles.size12w800Primary,
              ),
              Text(
                "Tab to create plan",
                style: !enableChangeMonth
                    ? TextStyles.size12w200
                    : TextStyles.size12w800Primary,
              ),
              const SizedBox(height: SizeConstants.kSize4),
              //AmountCompare(usage: usage, amount: amount),
              const SizedBox(height: SizeConstants.kSize10),
            ],
          ),
        ),
      ),
    );
  }
}
