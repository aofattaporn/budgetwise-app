import 'package:budget_wise/src/common/presentation/widgets/multi_segment_painter.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/screens/sheets/all_plans_sheet.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiSegmentCircularProgress extends StatelessWidget {
  final bool isSuccess;
  final bool isNotfound;
  final bool isShowMessage;
  final double size;
  final double strokeWidth;
  final List<TransactionsSegment> transactionsSegment;
  final double limitSalary;

  const MultiSegmentCircularProgress({
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    this.isShowMessage = true,
    required this.transactionsSegment,
    required this.limitSalary,
    required this.isSuccess,
    required this.isNotfound,
  });

  List<Color> get _segmentColors =>
      transactionsSegment.map((segment) => segment.color).toList();

  List<double> get _segmentUsages => transactionsSegment
      .map((segment) => (segment.usage * 100.0) / limitSalary)
      .toList();

  double get _totalProgress =>
      transactionsSegment.fold(0, (sum, value) => sum + value.usage);

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
          if (isShowMessage) _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) => isNotfound
      ? _buildNotFoundContent(context)
      : _buildContentExsting(context);

  Widget _buildContentExsting(BuildContext context) =>
      isSuccess ? _buildSuccessContent() : _buildErrorContent(context);

  Widget _buildSuccessContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            '${UtilsDateTime.monthYearFormat(isSuccess ? DateTime.now() : DateTime.now())} - ${UtilsDateTime.monthYearFormat(isSuccess ? DateTime.now() : DateTime.now())}',
            style: AppTextStyles.labelGraySmall),
        AmountCompare(usage: _totalProgress, limitAmount: limitSalary),
        const SizedBox(height: 8),
        Text("${((_totalProgress * 100) / limitSalary).round()}%",
            style: AppTextStyles.labelGraySmall),
        const Text("Progress", style: AppTextStyles.labelGraySmall),
      ],
    );
  }

  Widget _buildErrorContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Something went wrong", style: AppTextStyles.labelGraySmall),
        TextButton(
          onPressed: () {
            context.read<PlanBloc>().add(FetchCurrentMonthPlan());
          },
          child: const Text("Retry"),
        ),
        const Text("Error", style: AppTextStyles.labelGraySmall),
      ],
    );
  }

  Widget _buildNotFoundContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Not Found Plan", style: AppTextStyles.labelGraySmall),
        const Text("on this current month",
            style: AppTextStyles.labelGraySmall),
        TextButton(
          onPressed: () {
            _showPlanModal(context);
          },
          child: const Text("View All Plan"),
        ),
      ],
    );
  }

  void _showPlanModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.6, // 60% of screen height
          child: const AllPlansSheet(),
        );
      },
    );
  }
}
