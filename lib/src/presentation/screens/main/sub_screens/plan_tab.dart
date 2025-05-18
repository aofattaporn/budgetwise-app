import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/active_plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/components/plan_item_card.dart';
import 'package:budget_wise/src/presentation/components/saving_slider.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/screens/plans/plan_overview_screen.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentPlanBloc>().add(FetchCurrentPlanEvent());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.8,
            padding: const EdgeInsets.all(16),
            decoration: _buildBgBoxGradient(),
            child: Column(
              spacing: 36,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBudgetHeader(context),
                _buildBudgetOverview(context),
                _buildPlanItemSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetHeader(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const String kMessageHeader = "Monthly Budget";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        SizedBox(height: screenHeight * 0.06), // 6% of screen
        Text(
          kMessageHeader,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.background),
        ),

        GestureDetector(
          onTap: () => CustomCommonSheet()
              .open(context, widget: const PlanOverviewScreen()),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.background,
                ),
                BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
                  builder: (context, state) {
                    String messageDateTime;
                    if (state is CurrentPlanLoading) {
                      messageDateTime = 'Plan Loading...';
                    } else if (state is CurrentPlanEmpty) {
                      messageDateTime = 'Not found Plan active this month';
                    } else if (state is CurrentPlanLoaded) {
                      messageDateTime =
                          "${UtilsDateTime.monthYearFormat(state.plan.startDate)} - "
                          "${UtilsDateTime.monthYearFormat(state.plan.endDate)}";
                    } else {
                      messageDateTime = "something went wrong.";
                    }

                    return Skeletonizer(
                      enabled: (state is CurrentPlanLoading),
                      child: Text(
                        messageDateTime,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.background),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetOverview(BuildContext context) {
    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
      builder: (BuildContext context, CurrentPlanState state) {
        final isLoading = (state is CurrentPlanLoading);
        final isLoaded = (state is CurrentPlanLoaded);
        final isNotfound = (state is CurrentPlanEmpty);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.planDetail),
              child: MultiSegmentCircularProgress(
                isLoading: isLoading,
                isNotfound: isNotfound,
                plan: isLoaded ? state.plan : null,
              ),
            ),
            const SizedBox(width: 24),
            isLoaded
                ? Expanded(child: _buildBudgetDetail(context, state.plan))
                : Container()
          ],
        );
      },
    );
  }

  Widget _buildBudgetDetail(BuildContext context, PlanEntity plan) {
    const String kMessageHeader = "budget usage";
    final daysLeft = plan.endDate.difference(DateTime.now()).inDays;

    return Column(
      spacing: 12,
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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$daysLeft ",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.background),
          ),
          Text(
            "Days left",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.background),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItemSection(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.25;

    return Expanded(
      child: Column(
        spacing: 14,
        children: [
          Row(
            children: [
              Text("Plan item List",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.background))
            ],
          ),
          SizedBox(
            height: cardHeight * 0.9,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => const PlanItemCard()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBgBoxGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      ),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24),
      ),
    );
  }
}
