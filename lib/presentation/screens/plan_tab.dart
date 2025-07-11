import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_bloc.dart';
import 'package:budget_wise/app_config/theme/system/app_decoration.dart';
import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_event.dart';
import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_state.dart';
import 'package:budget_wise/presentation/bloc/widget_state/widdgt_stat.dart';
import 'package:budget_wise/presentation/components/card_plan_item.dart';
import 'package:budget_wise/presentation/screens/plan_all_item_screen.dart';
import 'package:budget_wise/shared/common/custom_common_sheet.dart';
import 'package:budget_wise/shared/components/segment_circular_progress_new.dart';
import 'package:budget_wise/presentation/sheets/planning_overview_sheet.dart';
import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetPlanBloc>().add(LoadBudgetPlan());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight * 0.75, //  70% of bg
          padding: const EdgeInsets.all(16),
          decoration: AppDecorations.gradientBottomRounded,
          child: Column(
            spacing: 36,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // **
              // Select Plan Budget
              // **
              BlocBuilder<BudgetPlanBloc, BudgetPlanState>(
                  builder: (context, planState) {
                String text;
                String? planIdSelected;
                if (planState is BudgetPlanLoading) {
                  text = CommonConstant.loadingLabel;
                } else if (planState is BudgetPlanLoaded) {
                  planIdSelected = planState.planMonthlyBudget.id;
                  text =
                      "${UtilsDateTime.dayMonthYearFormat(planState.planMonthlyBudget.startDate)} - ${UtilsDateTime.dayMonthYearFormat(planState.planMonthlyBudget.endDate)}";
                } else {
                  text = CommonConstant.msgPleasToTryAgain;
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 36),
                      child: Text(
                        "Select Plan Budget",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: AppColors.background),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        CustomCommonSheet().open(context,
                            widget: PlanningOverviewSheet(
                                planIdSelected: planIdSelected));
                      },
                      child: Text(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                );
              }),

              // **
              // BudgetPlanBloc
              // **
              BlocBuilder<BudgetPlanBloc, BudgetPlanState>(
                  builder: (context, planState) {
                final isLoaded = planState is BudgetPlanLoaded;
                return MultiSegmentCircularProgressNew(
                    plan: isLoaded ? planState.planMonthlyBudget : null,
                    blocParentState: () {
                      if (planState is BudgetPlanLoading) {
                        return BlocParentLoadingState();
                      } else if (planState is BudgetPlanError) {
                        return BlocParentErrorState(planState.message);
                      } else if (planState is BudgetPlanEmpty) {
                        return BlocParentErrorState(planState.message);
                      } else if (planState is BudgetPlanLoaded) {
                        return BlocParentStateComplete();
                      } else {
                        return BlocParentInitialState();
                      }
                    }());
              }),

              // **
              // Plan_ite_list
              // - name / amount /
              // **
              BlocBuilder<BudgetPlanBloc, BudgetPlanState>(
                  builder: (context, planState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 0,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO : manage dynamic route
                        // Navigator.pushNamed(context, '/plan-budget');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PlanAllItemScreen()));
                      },
                      child: Text("see more plan budget >",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.background)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 20,
                        children: [
                          CardPlan(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                          CardPlan(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                          CardPlan(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight)
                        ],
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ],
    ));
  }
}
