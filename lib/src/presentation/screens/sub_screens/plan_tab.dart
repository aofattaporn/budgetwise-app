import 'package:budget_wise/src/presentation/common/widgets/common_notification.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/theme/app_shadow.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:budget_wise/src/presentation/widgets/plan_item.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/widgets/summary_plan_segemennt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  final List<String> planShowLabels = [
    BusinessConstant.savingType,
    BusinessConstant.tranfersType,
    BusinessConstant.unplannedType,
  ];

  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(FetchCurrentMonthPlan());
  }

  void _saveNewPlanning(BuildContext context) {
    // TODO: implement create plan item
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.allxl,
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          if (state is PlanError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CommonNotification.showSnackBar(context, state.message);
            });
          }

          final isLoading = state is PlanLoading;
          final isSuccess = state is PlanLoaded;
          final isNotFound = state is PlanNotFound;

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                _buildPlanProgress(state, isSuccess, isNotFound),
                const SizedBox(height: 12),
                if (isSuccess) _buildPlanSegments(state),
                const SizedBox(height: 12),
                if (isSuccess) _buildPlanItems(state),
                if (!isSuccess) const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlanProgress(PlanState state, bool isSuccess, bool isNotFound) {
    return Container(
      padding: AppPadding.hxxs,
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          if (isSuccess) {
            final planId = (state as PlanLoaded).plan.id ?? 0;
            CustomCommonSheet().allPlansSheet(context, planId);
          }
        },
        child: Center(
          child: MultiSegmentCircularProgress(
            isNotfound: isNotFound,
            plan: isSuccess ? (state as PlanLoaded).plan : null,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSegments(PlanState state) {
    final plan = (state as PlanLoaded).plan;

    return Column(
      children: [
        SummaryPlanSegment(
          limitAmount: plan.totalBudget,
          segmentTilel: BusinessConstant.savingType,
          usage: plan.summarySaving,
          segmentColor: AppColors.priamryDark,
        ),
        const SizedBox(height: 8),
        SummaryPlanSegment(
          limitAmount: plan.totalBudget,
          segmentTilel: BusinessConstant.tranfersType,
          usage: plan.summaryTranfer,
          segmentColor: AppColors.primary,
        ),
        const SizedBox(height: 8),
        SummaryPlanSegment(
          limitAmount: plan.totalBudget,
          segmentTilel: BusinessConstant.unplannedType,
          usage: plan.summaryOther,
          segmentColor: AppColors.primarySubtle,
        ),
      ],
    );
  }

  Widget _buildPlanItems(PlanState state) {
    final planId = (state as PlanLoaded).plan.id!;
    context.read<PlanItemBloc>().add(FetchPlanItemEvent(planId));

    return Expanded(
      child: Column(
        children: [
          _buildActionButton(),
          const SizedBox(height: 16),
          _buildPlanItemList(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: AppPadding.hxxs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () => _saveNewPlanning(context),
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

  Widget _buildPlanItemList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadow.sm,
        ),
        child: BlocBuilder<PlanItemBloc, PlanItemState>(
          builder: (context, state) {
            if (state is PlanItemLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PlanItemEmpty) {
              return _buildEmptyPlanItemView();
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

            return const Center(child: Text("Something went wrong..."));
          },
        ),
      ),
    );
  }

  Widget _buildEmptyPlanItemView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
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
}
