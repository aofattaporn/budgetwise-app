import 'package:budget_wise/core/utils/datetime_util.dart';
import 'package:budget_wise/features/plan/data/models/plan_dto.dart';
import 'package:budget_wise/features/plan/data/models/plan_item_dto.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/components/plan_item_card.dart';
import 'package:budget_wise/src/presentation/components/saving_slider.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/screens/plans/plan_overview_screen.dart';
import 'package:budget_wise/src/presentation/screens/plans/sheets/create_new_plan_item_sheet.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/system/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<CurrentPlanBloc>();
      final state = bloc.state;
      if (state is! CurrentPlanLoaded || state is CurrentPlanEmpty) {
        bloc.add(FetchCurrentPlanEvent());
      }
    });
  }

  void _onCurrentPlanStateChanged(
      BuildContext context, CurrentPlanState state) {
    if (state is CurrentPlanLoaded) {
      final planId = state.plan.id;
      context.read<PlanItemBloc>().add(FetchPlanItems(planId!));
    }

    if (state is CurrentPlanDeleted) {
      context.read<PlanItemBloc>().add(ResetPlanItemEmpty());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<CurrentPlanBloc, CurrentPlanState>(
      listenWhen: (previous, current) => current is CurrentPlanLoaded,
      listener: _onCurrentPlanStateChanged,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.7, //  80% of bg
              padding: const EdgeInsets.all(16),
              decoration: AppDecorations.gradientBottomRounded,
              child: Column(
                spacing: 36,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBudgetHeader(context),
                  _buildBudgetOverview(context),
                  _buildPlanItemSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetHeader(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const String kMessageHeader = "Monthly Budget";

    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
      builder: (context, state) {
        final bool isLoading = state is CurrentPlanLoading;

        final String messageDateTime = switch (state) {
          CurrentPlanLoading _ => 'Plan Loading...',
          CurrentPlanEmpty _ => 'Click to start planng ! ',
          CurrentPlanLoaded _ =>
            "${UtilsDateTime.dayMonthYearFormat(state.plan.startDate)} - ${UtilsDateTime.dayMonthYearFormat(state.plan.endDate)}",
          _ => "Something went wrong.",
        };

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Text(
                kMessageHeader,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.background),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => CustomCommonSheet()
                    .open(context, widget: const PlanOverviewScreen()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.background,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        messageDateTime,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.background),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBudgetOverview(BuildContext context) {
    return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
      builder: (BuildContext context, CurrentPlanState state) {
        final isLoading = (state is CurrentPlanLoading);
        final isLoaded = (state is CurrentPlanLoaded);
        final isNotfound = (state is CurrentPlanEmpty);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (isLoaded) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.planDetail,
                    arguments: state.plan,
                  );
                }
              },
              child: MultiSegmentCircularProgress(
                isLoading: isLoading,
                isNotfound: isNotfound,
                plan: isLoaded ? state.plan : null,
              ),
            ),
            const SizedBox(width: 12),

            // Show budget detail if loaded
            if (isLoaded)
              Expanded(child: _buildBudgetDetail(context, state.plan)),

            // Show placeholder or fallback when not found
            if (isNotfound)
              Expanded(
                child: Center(
                  child: Text(
                    "Nothing here yet\nstart planning!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.background,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 15,
                          color: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBudgetDetail(BuildContext context, PlanDto plan) {
    const String kMessageHeader = "budget usage";
    final daysLeft = plan.endDate.difference(DateTime.now()).inDays;

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAmountRow(context, daysLeft: daysLeft),
        Text(
          kMessageHeader,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.background),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SavingSlider(),
      ],
    );
  }

  Widget _buildAmountRow(BuildContext context, {required int daysLeft}) {
    String message;

    if (daysLeft == 0) {
      message = "Today";
    } else if (daysLeft == 1) {
      message = "Tomorrow";
    } else if (daysLeft == -1) {
      message = "Yesterday";
    } else if (daysLeft > 1) {
      message = "$daysLeft days left";
    } else {
      message = "${daysLeft.abs()} days ago";
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: AppColors.background),
      ),
    );
  }

  Widget _buildPlanItemSection(BuildContext context) {
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

                  return Skeletonizer(
                    enabled: isLoading,
                    child: CustomCommonWidget.commonElevatedBtn(
                      label: "Create Plan",
                      isDisable: isError,
                      onPressed: () {
                        CustomCommonSheet(height: 0.5).open(context,
                            widget: CreateOrEditPlanItemSheet(
                              planId: isLoaded ? state.plan.id! : "",
                            ));
                      },
                    ),
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
                        "Failed to load items: ${state.message}",
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

                    return _buildPlanItemCarousel(
                        items, isLoaded ? planState.plan.amountLimit : 0);
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

  Widget _buildPlanItemCarousel(List<PlanItemDto> items, double amountLimit) {
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


      // child: CustomCommonWidget.commonElevatedBtn(
      //                 label: "Create Plan",
      //                 isDisable: isError,
      //                 onPressed: () {
      //                   CustomCommonSheet(height: 0.5).open(context,
      //                       widget: CreateOrEditPlanItemSheet(
      //                         planId: isLoaded ? state.plan.id! : "",
      //                       ));
      //                 },
      //               ),