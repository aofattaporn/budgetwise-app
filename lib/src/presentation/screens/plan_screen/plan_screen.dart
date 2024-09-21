import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/bloc/users/users_bloc.dart';
import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:budget_wise/src/bloc/users/users_state.dart';
import 'package:budget_wise/src/presentation/screens/create_plan_sheet/create_plan_sheet.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label_loading.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  double currentTotalUsage = 0;
  double limitAmount = 0;

  @override
  void initState() {
    super.initState();

    // Trigger event calls only once when the widget is initialized.
    context.read<UsersBloc>().add(GetSalaryEvent());
    context.read<PlansBloc>().add(GetPlansEvent());
  }

  _popUpShowCreatePlan(
      BuildContext context, double currentTotalUsage, limitAmount) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreatePlanSheet(
          currentTotalUsage: currentTotalUsage,
          limitAmount: limitAmount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersBloc, UsersState>(
          listener: (context, state) {
            if (state is GetSalaryAndDateResetSuccess) {
              setState(() {
                this.limitAmount = state.data.salary;
              });
            }
          },
        ),
        BlocListener<PlansBloc, PlansState>(
          listener: (context, state) {
            if (state is GetPlanSuccess) {
              setState(() {
                this.currentTotalUsage =
                    state.data.fold(0, (sum, item) => sum + item.limit);
              });
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Container(
          margin: const EdgeInsets.all(16),
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
                if (state is GetSalaryAndDateResetSuccess)
                  return BudgetLimitLabel(
                      currentUsage: 5000,
                      limitBudgetPlan: state.data.salary,
                      dateReset: state.data.resetDatePlanning);
                else if (state is GetSalaryAndDateResetSuccess)
                  return BudgetLimitLabelLoading();
                else
                  return BudgetLimitLabelLoading();
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Planing",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GenericTxtBTN(
                    title: "+ Create Planning",
                    handler: () => {
                      _popUpShowCreatePlan(
                          context, this.currentTotalUsage, this.limitAmount)
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.9,
                clipBehavior: Clip.none,
                child: BlocBuilder<PlansBloc, PlansState>(
                  builder: (context, state) {
                    if (state is GetPlanSuccess) {
                      return GridView.count(
                        primary: false,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        children: List.generate(state.data.length, (index) {
                          return PlanPocket(
                              isFullSize: false, planning: state.data[index]);
                        }),
                      );
                    } else if (state is GetPlanLoading) {
                      return GridView.count(
                        primary: false,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        children: List.generate(6, (index) {
                          return PlanPocketLoading();
                        }),
                      );
                    } else {
                      return Center(child: Text('No plans available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
