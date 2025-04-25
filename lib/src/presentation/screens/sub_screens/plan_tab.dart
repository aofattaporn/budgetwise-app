import 'package:budget_wise/src/common/presentation/widgets/common_notification.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/common/presentation/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The main screen tab for displaying a plan-related view.
///
/// This widget displays various components, including:
/// - A segmented circular progress bar showing the usage of different segments.
/// - A summary container showing the details of transaction segments like "Transfers", "Savings", etc.
/// - A placeholder for a list of items related to the plan.
class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(FetchCurrentMonthPlan());
    // context.read<PlanItemBloc>().add(FetchPlanItemEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.allxl,
      // ! [ PlanBloc ] : update curcular progress pocket
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (BuildContext context, PlanState planState) {
          // handle provide plan state
          final bool isLoading = planState is PlanLoading;
          final bool isSuccess = planState is PlanLoaded;
          final bool isNotfound = planState is PlanNotFound;

          if (planState is PlanError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CommonNotification.showSnackBar(context, planState.message);
            });
          }

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              spacing: 16,
              children: [
                Container(
                  padding: AppPadding.allxl,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GestureDetector(
                    onTap: () => isSuccess
                        ? CustomCommonSheet()
                            .allPlansSheet(context, planState.plan.id ?? 0)
                        : null,
                    child: Center(
                      child: MultiSegmentCircularProgress(
                        isNotfound: isNotfound,
                        plan: isSuccess ? planState.plan : null,
                      ),
                    ),
                  ),
                ),
                isSuccess
                    ? Column(
                        spacing: 12,
                        children: [
                          SummaryPlanSegment(
                              limitAmount: planState.plan.totalBudget,
                              segmentTilel: BusinessConstant.savingType,
                              usage: planState.plan.summarySaving,
                              segmentColor: AppColors.priamryDark),
                          SummaryPlanSegment(
                              limitAmount: planState.plan.totalBudget,
                              segmentTilel: BusinessConstant.tranfersType,
                              usage: planState.plan.summaryTranfer,
                              segmentColor: AppColors.primary),
                          SummaryPlanSegment(
                              limitAmount: planState.plan.totalBudget,
                              segmentTilel: BusinessConstant.notPlanType,
                              usage: planState.plan.summaryOther,
                              segmentColor: AppColors.primarySubtle)
                        ],
                      )
                    : const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
