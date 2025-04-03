import 'package:budget_wise/src/common/presentation/widgets/common_notification.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/core/utils/plan_util.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/presentation/screens/sheets/all_plans_sheet.dart';
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
  /// Mock method for the amount limit.
  ///
  /// Returns a mock amount limit of 30,000.00, representing the budget limit.
  /// This method is a placeholder for the actual logic.
  double getMockAmountLimit() {
    return 30000.00;
  }

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

          final double limitSalary =
              !isSuccess ? 1 : planState.plan.totalBudget;

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
                    onTap: () => _showPlanModal(context),
                    child: Center(
                      child: MultiSegmentCircularProgress(
                        transactionsSegment:
                            PlanUtil.generatePlannTransactionSegment(
                                isSuccess ? planState.plan : null),
                        limitSalary: limitSalary,
                        isSuccess: isSuccess,
                        isNotfound: isNotfound,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
