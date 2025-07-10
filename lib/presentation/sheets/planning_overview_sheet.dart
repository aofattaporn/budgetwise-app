import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/presentation/bloc/budget_all_plan_bloc/budget_plan_bloc.dart';
import 'package:budget_wise/presentation/bloc/budget_all_plan_bloc/budget_plan_state.dart';
import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/budget_all_plan_bloc/budget_plan_event.dart';

class PlanningOverviewSheet extends StatefulWidget {
  final String? planIdSelected;
  const PlanningOverviewSheet({super.key, this.planIdSelected});

  @override
  State<PlanningOverviewSheet> createState() => _PlanningOverviewSheetState();
}

class _PlanningOverviewSheetState extends State<PlanningOverviewSheet> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetAllPlanBloc>().add(LoadAllBudgetPlan());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          "Planning Overview",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        BlocBuilder<BudgetAllPlanBloc, BudgetAllPlanState>(
          builder: (context, state) {
            if (state is GetAllPlanLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllPlanLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.listPlanDto.length,
                itemBuilder: (context, index) {
                  final plan = state.listPlanDto[index];
                  return PlanBudgetCardOvrview(plan: plan);
                },
              );
            } else if (state is GetAllPlanError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class PlanBudgetCardOvrview extends StatelessWidget {
  const PlanBudgetCardOvrview({
    super.key,
    required this.plan,
  });

  final PlanDto plan;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Background decoration
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(250),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
                "Date: ${UtilsDateTime.dayMonthYearFormat(plan.startDate)} - ${UtilsDateTime.dayMonthYearFormat(plan.endDate)}"),
            Text("Total Budget: ${plan.amountLimit} Bath"),
          ],
        ),
      ),

      // Text overlay
      Positioned(
        bottom: 16,
        right: 32,
        child: Text(
          plan.isArchived ? "DeActive" : "Active",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).primaryColorDark.withAlpha(100),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    ]);
  }
}
