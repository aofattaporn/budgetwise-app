import 'package:budget_wise/src/common/presentation/widgets/multi_segment_painter.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:flutter/material.dart';

class MultiSegmentCircularProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final List<TransactionsSegment> transactionsSegment;
  final double limitSalary;

  const MultiSegmentCircularProgress({
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    required this.transactionsSegment,
    required this.limitSalary,
  });

  List<Color> getColors(List<TransactionsSegment> transactionsSegment) {
    return transactionsSegment.map((segment) => segment.color).toList();
  }

  List<double> getUsages(
      List<TransactionsSegment> transactionsSegment, double limitSalary) {
    return transactionsSegment
        .map((segment) => (((segment.usage) * 100.0) / limitSalary))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double totalProgress =
        transactionsSegment.fold(0, (sum, value) => sum + value.usage);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
              size: Size(size, size),
              painter: MultiSegmentPainter(
                  getUsages(transactionsSegment, limitSalary),
                  getColors(transactionsSegment),
                  10,
                  0)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "12 May - 14 Jun",
                style: AppTextStyles.labelGraySmall,
              ),
              AmountCompare(
                usage: totalProgress,
                limitAmount: limitSalary,
              ),
              const SizedBox(height: 8),
              Text(
                "${((totalProgress * 100) / limitSalary).round()}%",
                style: AppTextStyles.labelGraySmall,
              ),
              const Text(
                "Progress",
                style: AppTextStyles.labelGraySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
