import 'package:budget_wise/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class PlanBudgetCard extends StatelessWidget {
  const PlanBudgetCard({
    super.key,
    required this.plans,
    required this.selectedPlanId,
  });

  final PlanDto plans;
  final String? selectedPlanId;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = plans.id == selectedPlanId;
    final theme = Theme.of(context);
    final bool isArchived = plans.isArchived;

    // Define default styles
    TextStyle titleStyle = theme.textTheme.headlineSmall!;
    TextStyle dateTextStyle = theme.textTheme.labelSmall!;
    Color badgeColor = theme.primaryColor;
    BoxDecoration? containerDecoration;

    // If selected, override styles
    if (isSelected) {
      titleStyle = titleStyle.copyWith(color: AppColors.background);
      dateTextStyle = dateTextStyle.copyWith(color: AppColors.background);
      badgeColor = theme.primaryColorDark;

      containerDecoration = BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: containerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MultiSegmentCircularProgress(
            size: 90,
            isShowMessage: false,
            isNotfound: false,
            plan: null,
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(plans.name, style: titleStyle),
              Text(
                "${UtilsDateTime.dayMonthYearFormat(DateTime.now())} - ${UtilsDateTime.dayMonthYearFormat(DateTime.now())}",
                style: dateTextStyle,
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: badgeColor,
                ),
                child: Text(
                  isArchived ? "Archived" : "Active",
                  style: const TextStyle(color: AppColors.background),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
