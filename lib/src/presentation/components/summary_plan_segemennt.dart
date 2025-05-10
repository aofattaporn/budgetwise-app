import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/system/app_text_style.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/presentation/components/amount_compare.dart';
import 'package:flutter/widgets.dart';

class SummaryPlanSegment extends StatelessWidget {
  final String segmentTilel;
  final double usage;
  final double limitAmount;
  final Color segmentColor;
  const SummaryPlanSegment({
    super.key,
    required this.segmentTilel,
    required this.usage,
    required this.limitAmount,
    required this.segmentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: segmentColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(segmentTilel,
                style: const TextStyle(color: AppColors.white))),
        Text('(${NumberUtil.calPercentage(usage, limitAmount).toString()}%)',
            style: AppTextStyles.labelGraySmall),
        const Spacer(),
        AmountCompare(usage: usage, limitAmount: limitAmount)
      ],
    );
  }
}
