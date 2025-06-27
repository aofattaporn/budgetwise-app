import 'package:budget_wise/features/plan/presentation/components/plan_budget_header.dart';
import 'package:budget_wise/features/plan/presentation/components/plan_budget_overview.dart';
import 'package:budget_wise/features/plan/presentation/components/plan_item_section.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:budget_wise/app_config/theme/system/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/common/common_flash_message.dart';

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
      child: BlocListener<PlanItemBloc, PlanItemState>(
        listener: (BuildContext context, PlanItemState state) {
          if (state is PlanItemError) {
            CommonFlashMessage.show(
              context,
              message: state.message,
            );
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.7, //  70% of bg
                padding: const EdgeInsets.all(16),
                decoration: AppDecorations.gradientBottomRounded,
                child: const Column(
                  spacing: 36,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BudgetHeader(),
                    BudgetOverview(),
                    PlanItemSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
