import 'package:budget_wise/src/common/routes/app_routes.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_state.dart';
import 'package:budget_wise/src/presentation/screens/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningOverviewSheet extends StatefulWidget {
  final int planIdSelected;
  const PlanningOverviewSheet({required this.planIdSelected, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlanningOverviewSheetState createState() => _PlanningOverviewSheetState();
}

class _PlanningOverviewSheetState extends State<PlanningOverviewSheet> {
  @override
  void initState() {
    super.initState();
    context.read<PlanAllMonthBloc>().add(FetchAllPlans());
  }

  void navigateToNewPlanning() {
    Navigator.pushNamed(context, AppRoutes.newPlanningScreen);
  }

  @override
  Widget build(BuildContext context) {
    const String kAllPlaning = "All Plans";

    return Column(
      spacing: 12,
      children: [
        const Text(
          kAllPlaning,
          style: AppTextStyles.headlineSmall,
        ),
        _buildActionPlan(context),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.allxl,
            child: _buildListItems(),
          ),
        ),
      ],
    );
  }

  Widget _buildListItems() {
    return BlocBuilder<PlanAllMonthBloc, PlanAllMonthState>(
        builder: (context, state) {
      return switch (state) {
        AllPlanLoading() => _buildPlanLoading("Loading..."),
        AllPlanLoaded() => _buildPlanListItem(state.plans),
        _ => _buildPlanLoading("Somthing when wrong."),
      };
    });
  }

  Padding _buildActionPlan(BuildContext context) {
    return Padding(
      padding: AppPadding.hmd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: navigateToNewPlanning, child: const Text("Add New"))
        ],
      ),
    );
  }

  SizedBox _buildPlanLoading(String message) {
    return SizedBox(
      width: double.infinity,
      child: Center(child: Text(message, style: AppTextStyles.bodyMedium)),
    );
  }

  ListView _buildPlanListItem(List<PlanEntity> plans) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        return Component.planItemComponent(plans[index],
            selectedId: widget.planIdSelected);
      },
    );
  }
}
