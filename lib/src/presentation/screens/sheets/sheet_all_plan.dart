import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_state.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SheetAllPlan extends StatefulWidget {
  final int planIdSelected;
  const SheetAllPlan({required this.planIdSelected, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SheetAllPlanState createState() => _SheetAllPlanState();
}

class _SheetAllPlanState extends State<SheetAllPlan> {
  @override
  void initState() {
    super.initState();
    context.read<PlanAllMonthBloc>().add(FetchAllPlans());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          "All Plans",
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: AppPadding.hmd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text("Add New"))
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppPadding.allxl,
            child: Column(
              children: [
                _buildListItems(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectedViewPlan(int id) {
    context.read<PlanBloc>().add(FetchtPlanByMId(id: id));
    Navigator.pop(context);
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
        return GestureDetector(
          onTap: () => _selectedViewPlan(plans[index].id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: AppPadding.allxl,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadow.lg,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildContentPlanDetail(plans[index]),
                const Spacer(),
                Expanded(
                  child: MultiSegmentCircularProgress(
                      size: 80,
                      strokeWidth: 6,
                      isShowMessage: false,
                      plan: plans[index]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column _buildContentPlanDetail(PlanEntity plan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${UtilsDateTime.monthYearFormat(plan.startDate)} - ${UtilsDateTime.monthYearFormat(plan.endDate)}',
            style: plan.id == widget.planIdSelected
                ? AppTextStyles.labelPrimarySmall
                : AppTextStyles.labelGraySmall),
        AmountCompare(
            isLarge: true,
            usage: plan.summaryOther + plan.summaryTranfer + plan.summaryOther,
            limitAmount: plan.totalBudget),
      ],
    );
  }
}
