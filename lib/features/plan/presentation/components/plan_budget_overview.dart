import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/app_config/routes/app_routes.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/shared/components/segmented_circular_progress.dart';
import 'package:budget_wise/shared/components/saving_slider.dart';

class BudgetOverview extends StatelessWidget {
  const BudgetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
      builder: (BuildContext context, CurrentPlanState state) {
        final isLoading = (state is CurrentPlanLoading);
        final isLoaded = (state is CurrentPlanLoaded);
        final isNotfound = (state is CurrentPlanEmpty);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (isLoaded) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.planDetail,
                    arguments: state.plan,
                  );
                }
              },
              child: MultiSegmentCircularProgress(
                isLoading: isLoading,
                isNotfound: isNotfound,
                plan: isLoaded ? state.plan : null,
              ),
            ),
            const SizedBox(width: 12),

            // Show budget detail if loaded
            if (isLoaded)
              Expanded(child: _buildBudgetDetail(context, state.plan)),

            // Show placeholder or fallback when not found
            if (isNotfound)
              Expanded(
                child: Center(
                  child: Text(
                    "Nothing here yet\nstart planning!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.background,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 15,
                          color: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBudgetDetail(BuildContext context, PlanDto plan) {
    const String kMessageHeader = "budget usage";
    final daysLeft = plan.endDate.difference(DateTime.now()).inDays;

    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAmountRow(context, daysLeft: daysLeft),
        Text(
          kMessageHeader,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.background),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SavingSlider(),
      ],
    );
  }

  Widget _buildAmountRow(BuildContext context, {required int daysLeft}) {
    String message;

    if (daysLeft == 0) {
      message = "Today";
    } else if (daysLeft == 1) {
      message = "Tomorrow";
    } else if (daysLeft == -1) {
      message = "Yesterday";
    } else if (daysLeft > 1) {
      message = "$daysLeft days left";
    } else {
      message = "${daysLeft.abs()} days ago";
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: AppColors.background),
      ),
    );
  }
}
