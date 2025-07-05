import 'package:budget_wise/presentation/bloc/budget_plan_bloc/budget_plan_bloc.dart';
import 'package:budget_wise/app_config/theme/system/app_decoration.dart';
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
    context.read<BudgetPlanBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight * 0.7, //  70% of bg
          padding: const EdgeInsets.all(16),
          decoration: AppDecorations.gradientBottomRounded,
          child: const Column(
            spacing: 36,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("data"),
              // BudgetHeader(),
              // BudgetOverview(),
              // PlanItemSection(),
            ],
          ),
        ),
      ],
    ));
  }
}
