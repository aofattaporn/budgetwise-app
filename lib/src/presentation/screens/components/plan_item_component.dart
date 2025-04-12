import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemComponent extends StatelessWidget {
  final PlanEntity planEntity;
  final int? selectedId;

  const PlanItemComponent({
    super.key,
    required this.planEntity,
    this.selectedId, // Defaults to null by default
  });

  void _selectedViewPlan(int id, BuildContext context) {
    context.read<PlanBloc>().add(FetchtPlanByMId(id: id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectedViewPlan(planEntity.id ?? 0, context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: AppPadding.allxl,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadow.lg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MultiSegmentCircularProgress(
                size: 80,
                strokeWidth: 6,
                isShowMessage: false,
                plan: planEntity),
            const SizedBox(width: 20),
            _buildContentPlanDetail(planEntity),
          ],
        ),
      ),
    );
  }

  Expanded _buildContentPlanDetail(PlanEntity plan) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${UtilsDateTime.monthYearFormat(plan.startDate)} - ${UtilsDateTime.monthYearFormat(plan.endDate)}',
              style: plan.id == planEntity.id
                  ? AppTextStyles.labelPrimarySmall
                  : AppTextStyles.labelGraySmall),
          AmountCompare(
              isLarge: true,
              usage:
                  plan.summaryOther + plan.summaryTranfer + plan.summaryOther,
              limitAmount: plan.totalBudget),
          const SizedBox(height: 12),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 4), // minimal padding
                    textStyle: const TextStyle(
                        fontSize: 10, color: AppColors.primary), // tiny font
                    foregroundColor: AppColors.primary, // text & icon color
                    side: const BorderSide(
                        color: AppColors.primary), // red border
                    visualDensity:
                        VisualDensity.compact, // reduce button spacing
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // shrink touch area
                  ),
                  onPressed: () {},
                  child: const Text("Edit"),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    textStyle: const TextStyle(fontSize: 10),
                    foregroundColor: AppColors.error, // text & icon color
                    side:
                        const BorderSide(color: AppColors.error), // red border
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text("Delete"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
