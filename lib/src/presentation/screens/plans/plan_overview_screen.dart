import 'package:budget_wise/features/plan/data/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_state.dart';
import 'package:budget_wise/src/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlanOverviewScreen extends StatefulWidget {
  const PlanOverviewScreen({super.key});

  @override
  State<PlanOverviewScreen> createState() => _PlanOverviewScreenState();
}

class _PlanOverviewScreenState extends State<PlanOverviewScreen> {
  int selectedTypeIndex = 0;
  final List<String> planTypes = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    context.read<PlanSelectorBloc>().add(FetchAllMonthPlanEvent());
  }

  void _tabSelectNewPlan(BuildContext context, String id) {
    context.read<CurrentPlanBloc>().add(FetchPlanByIdEvent(planId: id));
    Navigator.pop(context);
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
              Navigator.pushNamed(context, AppRoutes.planDetail);
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
    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
        builder: (context, planState) {
      final selectedPlanId =
          planState is CurrentPlanLoaded ? planState.plan.id : null;

      return BlocBuilder<PlanSelectorBloc, PlanSelectorState>(
          builder: (context, state) {
        final isLoading = (state is PlanAllLoading);
        final isLoaded = (state is AllPlanLoaded);

        final List<PlanDto> originPlan = isLoaded ? state.planList : [];

        final plans = selectedTypeIndex == 1
            ? originPlan.where((op) => op.isArchived).toList()
            : originPlan.where((op) => !op.isArchived).toList();

        if (isLoading) {
          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: AppColors.primary,
              size: 54,
            ),
          );
        }

        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Container();
          },
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          itemCount: isLoaded ? plans.length : 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _tabSelectNewPlan(context, plans[index].id!),
              child: CustomCommonComponent.planBudgetCard(
                plan: plans[index],
                selectedPlanId: selectedPlanId,
              ),
            );
          },
        );
      });
    });
  }
}
