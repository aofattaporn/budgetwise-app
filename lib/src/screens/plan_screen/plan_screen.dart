import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/screens/plan_screen/list_planning_item/list_panning_item.dart';
import 'package:budget_wise/src/screens/plan_screen/summary_planning/summary_planning.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConstants.kPadd24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: SizeConstants.kFlex3,
            child: CircularStatsWidget(
              startDate: DateTime(2024, 2, 1),
              endDate: DateTime(2024, 2, 28),
              usage: 500,
              amount: 30000,
              percentage: (500 / 30000) * 100,
            ),
          ),
          const SizedBox(height: SizeConstants.kSize24),
          const Expanded(
            flex: SizeConstants.kFlex2,
            child: SummaryPlanning(),
          ),
          const SizedBox(height: SizeConstants.kSize24),
          const Expanded(
            flex: SizeConstants.kFlex4,
            child: ListPlanningItem(),
          )
        ],
      ),
    );
  }
}
