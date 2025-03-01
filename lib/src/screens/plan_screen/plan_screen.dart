import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/screens/plan_screen/list_planning_item/list_panning_item.dart';
import 'package:budget_wise/src/screens/plan_screen/next_screen.dart';
import 'package:budget_wise/src/screens/plan_screen/summary_planning/summary_planning.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          _blocCircleStatsWidget(),
          const SizedBox(height: SizeConstants.kSize24),
          _blocPlanItemWidget(),
          const SizedBox(height: SizeConstants.kSize24),
          _blocPlanItemList()
        ],
      ),
    );
  }

  BlocBuilder<PlanBloc, PlanState> _blocCircleStatsWidget() {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is GetPlanCurrentMonthSuccess) {
          final totalUsage = state.planItems
              .toList()
              .fold(0.0, (sum, item) => sum + item.usage);

          return Expanded(
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
                isLoanding: false,
                startDate: state.planInfo.startDate,
                endDate: state.planInfo.endDate,
                usage: totalUsage,
                amount: state.planInfo.totalBudget,
                percentage: (totalUsage / state.planInfo.totalBudget) *
                    CommonConstant.percentage,
                enableChangeMonth: false,
              ),
            ),
          );
        } else {
          return CircularStatsWidget(
            isLoanding: true,
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            usage: 0,
            amount: 0,
            percentage: 0,
            enableChangeMonth: false,
          );
        }
      },
    );
  }

  BlocBuilder<PlanBloc, PlanState> _blocPlanItemWidget() {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is GetPlanCurrentMonthSuccess) {
          return Expanded(
            flex: SizeConstants.kFlex2,
            child: SummaryPlanning(
              planItem: state.planItems,
              totalBudget: state.planInfo.totalBudget,
            ),
          );
        } else {
          return const Expanded(
            flex: SizeConstants.kFlex2,
            child: Skeletonizer(
                child: SummaryPlanning(
              planItem: [],
              totalBudget: 0,
            )),
          );
        }
      },
    );
  }

  BlocBuilder<PlanBloc, PlanState> _blocPlanItemList() {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is GetPlanCurrentMonthSuccess) {
          return Expanded(
            flex: SizeConstants.kFlex4,
            child: ListPlanningItem(
              planItem: state.planItems,
            ),
          );
        } else {
          return const Expanded(
            flex: SizeConstants.kFlex4,
            child: ListPlanningItem(
              planItem: [],
            ),
          );
        }
      },
    );
  }
}
