import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/system/app_text_style.dart';
import 'package:budget_wise/src/presentation/widgets/progression/multi_segment_painter.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/core/utils/plan_util.dart';
import 'package:budget_wise/src/presentation/components/amount_compare.dart';
import 'package:flutter/material.dart';

class MultiSegmentCircularProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final bool isShowMessage;
  final bool isNotfound;

  final PlanEntity? plan;

  const MultiSegmentCircularProgress({
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    this.isShowMessage = true,
    this.isNotfound = false,
    this.plan,
  });

  List<Color> get _segmentColors =>
      PlanUtil.generatePlannTransactionSegment(plan)
          .map((segment) => segment.color)
          .toList();

  List<double> get _segmentUsages =>
      PlanUtil.generatePlannTransactionSegment(plan)
          .map((segment) => (segment.usage * 100.0) / (40000 ?? 1))
          .toList();

  double get _totalProgress => PlanUtil.generatePlannTransactionSegment(plan)
      .fold(0, (sum, value) => sum + value.usage);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: isShowMessage
                    ? const [
                        BoxShadow(
                          color: AppColors.primaryDark,
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
                borderRadius: BorderRadius.circular(100)),
            child: CustomPaint(
                size: Size(size, size),
                painter:
                    MultiSegmentPainter(_segmentUsages, _segmentColors, 10, 0)),
          ),
          isShowMessage ? _buidContent(plan) : _percentage(plan, context)
        ],
      ),
    );
  }

  Column _buidContent(PlanEntity? plan) {
    if (plan != null) {
      return _msgSummaryPlan(plan);
    } else if (isNotfound) {
      return _msgPlanNotFound();
    } else {
      return _msgPlanError();
    }
  }

  Text _percentage(PlanEntity? plan, BuildContext context) {
    return Text("${NumberUtil.calPercentage(_totalProgress, 30000)}%",
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: AppColors.backgroundDark));
  }

  Column _msgSummaryPlan(PlanEntity plan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            '${UtilsDateTime.monthYearFormat(plan.startDate)} - ${UtilsDateTime.monthYearFormat(plan.endDate)}',
            style: AppTextStyles.labelGraySmall),
        AmountCompare(usage: _totalProgress, limitAmount: 30000),
        const SizedBox(height: 8),
        Text("${((_totalProgress * 100) / 30000).round()}%",
            style: AppTextStyles.labelGraySmall),
        const Text("Progress", style: AppTextStyles.labelGraySmall),
      ],
    );
  }

  Column _msgPlanError() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Something went wrong ?", style: AppTextStyles.labelGraySmall),
        Text("500 Error", style: AppTextStyles.labelGraySmall),
      ],
    );
  }

  Column _msgPlanNotFound() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This Plan Empty", style: AppTextStyles.labelGraySmall),
        Text("404 Not found", style: AppTextStyles.labelGraySmall),
      ],
    );
  }
}
