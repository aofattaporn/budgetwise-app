import 'package:budget_wise/src/presentation/widgets/progression/multi_segment_painter.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/core/utils/plan_util.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/components/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          .map((segment) => (segment.usage * 100.0) / (plan?.totalBudget ?? 1))
          .toList();

  double get _totalProgress => PlanUtil.generatePlannTransactionSegment(plan)
      .fold(0, (sum, value) => sum + value.usage);

  void fetchCurrentMonthPlan(BuildContext context) {
    context.read<PlanBloc>().add(FetchCurrentMonthPlan());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
              size: Size(size, size),
              painter:
                  MultiSegmentPainter(_segmentUsages, _segmentColors, 10, 0)),
          isShowMessage ? _buidContent(plan) : _percentage(plan)
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

  Text _percentage(PlanEntity? plan) {
    return Text(NumberUtil.calPercentage(_totalProgress, plan?.totalBudget ?? 0)
        .toString());
  }

  Column _msgSummaryPlan(PlanEntity plan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            '${UtilsDateTime.monthYearFormat(plan.startDate)} - ${UtilsDateTime.monthYearFormat(plan.endDate)}',
            style: AppTextStyles.labelGraySmall),
        AmountCompare(usage: _totalProgress, limitAmount: plan.totalBudget),
        const SizedBox(height: 8),
        Text("${((_totalProgress * 100) / plan.totalBudget).round()}%",
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
