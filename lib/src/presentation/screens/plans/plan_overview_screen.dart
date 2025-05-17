import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_all_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_all_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_all_state.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanOverviewScreen extends StatefulWidget {
  const PlanOverviewScreen({super.key});

  @override
  State<PlanOverviewScreen> createState() => _PlanOverviewScreenState();
}

class _PlanOverviewScreenState extends State<PlanOverviewScreen> {
  int selectedTypeIndex = 0;

  final List<String> planTypes = ['Active', 'Inactive'];
  final List<String> activePlans = [
    'Monthly Budget',
    'Trip Plan',
    'Home Renovation'
  ];
  final List<String> inactivePlans = ['Old Budget', 'Archived Plan'];

  @override
  void initState() {
    super.initState();
    context.read<PlanAllBloc>().add(FetchAllMonthPlanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        color: Theme.of(context).bottomAppBarTheme.color,
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildPlanList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        color: Theme.of(context).bottomAppBarTheme.color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(12),
            isSelected:
                List.generate(planTypes.length, (i) => i == selectedTypeIndex),
            onPressed: (index) {
              setState(() => selectedTypeIndex = index);
            },
            children: planTypes
                .map((type) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(type),
                    ))
                .toList(),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to create plan screen
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Create Plan"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlanList() {
    final plans = selectedTypeIndex == 0 ? activePlans : inactivePlans;

    if (plans.isEmpty) {
      return const Center(child: Text("No plans found"));
    }

    return BlocBuilder<PlanAllBloc, PlanAllState>(builder: (context, state) {
      final isLoaded = (state is AllPlanLoaded);
      return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        itemCount: isLoaded ? state.planList.length : 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              spacing: 24,
              children: [
                const MultiSegmentCircularProgress(
                  size: 90,
                  isShowMessage: false,
                  isNotfound: false,
                  plan: null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                        "${UtilsDateTime.monthYearFormat(DateTime.now())} - ${UtilsDateTime.monthYearFormat(DateTime.now())}",
                        style: Theme.of(context).textTheme.labelLarge),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          isLoaded
                              ? state.planList[index].isArchived
                                  ? "Archived"
                                  : "In Progress"
                              : "",
                          style: const TextStyle(color: AppColors.gray100),
                        ))
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
