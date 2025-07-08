import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:budget_wise/data/models/transaction_segment.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/app_config/theme/system/app_text_style.dart';
import 'package:budget_wise/shared/widgets/progression/multi_segment_painter.dart';
import 'package:budget_wise/shared/utils/numbers_uti.dart';
import 'package:budget_wise/shared/utils/plan_util.dart';
import 'package:budget_wise/shared/components/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MultiSegmentCircularProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final bool isError;
  final bool isLoading;
  final bool isNotfound;

  final PlanMonthlyBudget? plan;

  const MultiSegmentCircularProgress({
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    this.isLoading = true,
    this.isError = true,
    this.isNotfound = false,
    this.plan,
  });

  List<TransactionsSegment> get _segments =>
      PlanUtil.generatePlannTransactionSegment(plan);

  List<Color> get _segmentColors => _segments.map((e) => e.color).toList();

  List<double> get _segmentUsages => _segments
      .map((e) =>
          (e.usage * 100.0) /
          (plan?.amountLimit == 0 ? 1 : plan?.amountLimit ?? 1))
      .toList();

  double get _totalProgress => _segments.fold(0.0, (sum, e) => sum + e.usage);

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
                boxShadow: isError && !isNotfound
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
          isError ? _buidContent(plan, context) : _percentage(plan, context)
        ],
      ),
    );
  }

  Widget _buidContent(PlanMonthlyBudget? plan, BuildContext contex) {
    if (plan != null) {
      return _msgSummaryPlan(plan, contex);
    } else if (isNotfound) {
      return _msgPlanNotFound();
    } else if (isLoading) {
      return Center(
        child: LoadingAnimationWidget.horizontalRotatingDots(
          color: AppColors.primary,
          size: 54,
        ),
      );
    } else {
      return _msgPlanError();
    }
  }

  Text _percentage(PlanMonthlyBudget? plan, BuildContext context) {
    return Text("${NumberUtil.calPercentage(_totalProgress, 30000)}%",
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: AppColors.backgroundDark));
  }

  Column _msgSummaryPlan(PlanMonthlyBudget plan, BuildContext contex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(plan.name,
            style: Theme.of(contex)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.primaryDark)),
        const SizedBox(height: 8),
        AmountCompare(usage: _totalProgress, limitAmount: plan.amountLimit),
        const SizedBox(height: 8),
        Text("${((_totalProgress * 100) / plan.amountLimit).round()}%",
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "No active plan",
          style: TextStyle(
            color: Color.fromRGBO(60, 59, 59, 0.3),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          UtilsDateTime.monthYearFormat(DateTime.now()).toString(),
          style: const TextStyle(
            color: Color.fromRGBO(60, 59, 59, 0.3),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
