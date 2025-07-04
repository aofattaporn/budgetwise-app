import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:budget_wise/data/models/plan_item_dto.dart';
import 'package:budget_wise/presentation/sheets/create_new_plan_item_sheet.dart';
import 'package:budget_wise/shared/common/custum_common_widget.dart';
import 'package:budget_wise/shared/common/custom_common_sheet.dart';
import 'package:budget_wise/shared/components/plan_item_card.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class PlanItemSection extends StatelessWidget {
  const PlanItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  "Plan item List",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.background),
                ),
              ),
              Flexible(
                child: BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
                    builder: (context, state) {
                  final isLoading = state is CurrentPlanLoading;
                  final isLoaded = state is CurrentPlanLoaded;
                  final isError = state is CurrentPlanError;

                  return CustomCommonWidget.commonElevatedBtn(
                    label: "Create Plan",
                    isDisable: isError,
                    onPressed: () {
                      CustomCommonSheet(height: 0.5).open(context,
                          widget: CreateOrEditPlanItemSheet(
                            planId: isLoaded ? state.plan.id! : "",
                          ));
                    },
                  );
                }),
              )
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
                builder: (context, planState) {
              final isLoaded = (planState is CurrentPlanLoaded);
              return BlocBuilder<PlanItemBloc, PlanItemState>(
                builder: (context, state) {
                  if (state is PlanItemLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is PlanItemError) {
                    return Center(
                      child: Text(
                        "Failed to load items: {state.message}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.error),
                      ),
                    );
                  }

                  if (state is PlanItemLoaded) {
                    final items = state.items;
                    if (items.isEmpty) {
                      return _buildEmptyPlanItemMessage(context);
                    }

                    return _buildPlanItemCarousel(context, items,
                        isLoaded ? planState.plan.amountLimit : 0);
                  }

                  return const SizedBox();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlanItemMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Plan Items Yet",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.gray400.withAlpha(180),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Adding plan items to track your monthly budget.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.gray400.withAlpha(180),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItemCarousel(
      BuildContext context, List<PlanItemDto> items, double amountLimit) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => {
                      CustomCommonSheet(height: 0.5).open(context,
                          widget: CreateOrEditPlanItemSheet(
                            planId: item.planId,
                            planItemDto: item,
                          ))
                    },
                    child: PlanItemCard(
                      planItemDto: item,
                      planBudgetLiit: amountLimit,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
