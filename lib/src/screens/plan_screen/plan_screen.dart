import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/screens/plan_screen/list_planning_item/list_panning_item.dart';
import 'package:budget_wise/src/screens/plan_screen/next_screen.dart';
import 'package:budget_wise/src/screens/plan_screen/summary_planning/summary_planning.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(GetPlanByMonthEvent());
  }

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
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const NextScreen(),
                    ),
                  );
                },
                child: CircularStatsWidget(
                  startDate: DateTime(2024, 2, 1),
                  endDate: DateTime(2024, 2, 28),
                  usage: 500,
                  amount: 30000,
                  percentage: (500 / 30000) * 100,
                  enableChangeMonth: false,
                ),
              )),
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
