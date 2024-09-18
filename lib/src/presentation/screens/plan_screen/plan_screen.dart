import 'package:budget_wise/src/bloc/users/users_bloc.dart';
import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:budget_wise/src/bloc/users/users_state.dart';
import 'package:budget_wise/src/presentation/screens/create_plan_sheet/create_plan_sheet.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label_loading.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  _popUpShowCreatePlan(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreatePlanSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetSalaryEvent());

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Container(
        margin: const EdgeInsets.all(16),
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state is GetSalaryAndDateResetSuccess)
                return BudgetLimitLabel(salary: 2000);
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
                  handler: () => {_popUpShowCreatePlan(context)},
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.9,
              clipBehavior: Clip.none,
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: [
                  PlanPocket(isFullSize: false),
                  PlanPocket(isFullSize: false),
                  PlanPocket(isFullSize: false),
                  PlanPocket(isFullSize: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
