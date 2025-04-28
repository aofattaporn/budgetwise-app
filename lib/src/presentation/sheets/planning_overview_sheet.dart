import 'package:budget_wise/src/presentation/widgets/btn/common_icon_btn.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/theme/app_spacing.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_state.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningOverviewSheet extends StatefulWidget {
  final int planIdSelected;
  const PlanningOverviewSheet({required this.planIdSelected, super.key});

  @override
  State<PlanningOverviewSheet> createState() => _PlanningOverviewSheetState();
}

class _PlanningOverviewSheetState extends State<PlanningOverviewSheet> {
  final String kTitlePlanSheet = "Plan Overview";
  final String kAddNewLabel = "Add New";

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
    return Column(
      spacing: AppSpacing.xxl,
      children: [
        const SizedBox(height: 4),
        _buildActionPlan(context),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.allxl,
            child: Padding(
              padding: AppPadding.hmd,
              child: _buildListItems(),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildActionPlan(BuildContext context) {
    return Padding(
      padding: AppPadding.hxxl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(kTitlePlanSheet, style: AppTextStyles.displayPrimarySmall),
          CommonIconBtn(
              label: kAddNewLabel,
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: navigateToNewPlanning)
        ],
      ),
    );
  }

  Widget _buildListItems() {
    return BlocBuilder<PlanAllMonthBloc, PlanAllMonthState>(
        builder: (context, state) {
      return switch (state) {
        AllPlanLoading() ||
        CreatePlanSuccess() ||
        DeletePlanSuccess() =>
          _buildPlanLoading("Loading..."),
        AllPlanLoaded() => _buildPlanListItem(state.plans),
        _ => _buildPlanLoading("Somthing when wrong."),
      };
    });
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
        return CustomCommonComponent.planItemComponent(plans[index],
            selectedId: widget.planIdSelected);
      },
    );
  }
}
