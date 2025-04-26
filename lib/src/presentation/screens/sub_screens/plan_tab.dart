import 'package:budget_wise/src/common/presentation/widgets/common_notification.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/common/presentation/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
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
  final List<String> planShowLabels = [
    BusinessConstant.savingType,
    BusinessConstant.tranfersType,
    BusinessConstant.unplannedType
  ];

  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(FetchCurrentMonthPlan());
  }

  void saveNewPlanning(BuildContext context) {}

  // final List<PlanItem> mockPlanItems = [
  //   PlanItem(name: 'Saving for Car', totalAmount: 10000, usedAmount: 2500),
  //   PlanItem(name: 'Trip to Japan', totalAmount: 50000, usedAmount: 15000),
  //   PlanItem(name: 'Emergency Fund', totalAmount: 20000, usedAmount: 5000),
  //   PlanItem(name: 'Gadget Upgrade', totalAmount: 8000, usedAmount: 2000),
  // ];

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
              spacing: 12,
              children: [
                Container(
                  padding: AppPadding.hxxs,
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
                              segmentTilel: BusinessConstant.unplannedType,
                              usage: planState.plan.summaryOther,
                              segmentColor: AppColors.primarySubtle)
                        ],
                      )
                    : const SizedBox(),

                // ! [ PlanItemBloc ] :
                isSuccess
                    ? Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [_buildActionPlan(context)],
                            ),
                            const SizedBox(height: 16), // add spacing between
                            _buildAllPlanItem(planState.plan.id!),
                          ],
                        ),
                      )
                    : const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionPlan(BuildContext context) {
    return Padding(
      padding: AppPadding.hxxs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () => saveNewPlanning(context),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "New Item",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllPlanItem(int planId) {
    // 🚨 อย่า .add() ใน build นะ เดี๋ยวอธิบายต่อท้าย
    context.read<PlanItemBloc>().add(FetchPlanItemEvent(planId));

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadow.sm,
        ),
        child: BlocBuilder<PlanItemBloc, PlanItemState>(
          builder: (context, state) {
            if (state is PlanItemLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PlanItemEmpty) {
              return const Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox,
                        size: 56,
                        color: AppColors.primarySubtle,
                      ),
                      SizedBox(height: 24),
                      Text(
                        "No Items Yet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.priamryDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Create your first item.",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primarySubtle,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is PlanItemLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.planItems.length,
                itemBuilder: (context, index) {
                  final item = state.planItems[index];
                  final progress = item.usage / item.planAmount;
                  return PlannItem(item: item, progress: progress);
                },
              );
            }

            return const Center(
              child: Text("Something went wrong..."), // fallback case
            );
          },
        ),
      ),
    );
  }
}

class PlannItem extends StatelessWidget {
  const PlannItem({
    super.key,
    required this.item,
    required this.progress,
  });

  final PlanItemEntity item;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primarySubtle.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Name + Amount + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.usage} ฿',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: your action here
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: AppColors.primarySubtle.withOpacity(0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ],
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
