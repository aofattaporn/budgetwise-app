import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/features/plan/presentation/screens/plan_overview_screen.dart';
import 'package:budget_wise/shared/common/custom_common_sheet.dart';
import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BudgetHeader extends StatelessWidget {
  const BudgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const String kMessageHeader = "Monthly Budget";

    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
      builder: (context, state) {
        final bool isLoading = state is CurrentPlanLoading;

        final String messageDateTime = switch (state) {
          CurrentPlanLoading _ => 'Plan Loading...',
          CurrentPlanEmpty _ => 'Click to start planng ! ',
          CurrentPlanLoaded _ =>
            "${UtilsDateTime.dayMonthYearFormat(state.plan.startDate)} - ${UtilsDateTime.dayMonthYearFormat(state.plan.endDate)}",
          _ => "Something went wrong.",
        };

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Text(
                kMessageHeader,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.background),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => CustomCommonSheet()
                    .open(context, widget: const PlanOverviewScreen()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.background,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        messageDateTime,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
