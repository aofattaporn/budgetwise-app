import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket_create.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_accounts/select_all_accounts.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_icons/select_all_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlanSheet extends StatefulWidget {
  final double limitAmount;
  final double currentTotalUsage;

  CreatePlanSheet(
      {required this.limitAmount, required this.currentTotalUsage, super.key});

  @override
  State<CreatePlanSheet> createState() => _CreatePlanSheetState();
}

class _CreatePlanSheetState extends State<CreatePlanSheet> {
  final planingController = TextEditingController();
  final TextEditingController limitAmountController = TextEditingController();
  Account? accountVisit = null;
  int indexIcon = 0;

  void handleAccount(Account account) {
    setState(() {
      accountVisit = account;
    });
  }

  void handleIcon(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        indexIcon = index;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    planingController.addListener(_onTextChanged);
    limitAmountController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    planingController.removeListener(_onTextChanged);
    limitAmountController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlansBloc, PlansState>(
      listener: (BuildContext context, state) {
        if (state is CreatePlanSuccess) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BudgetLimitLabel(
                  currentUsage: widget.currentTotalUsage,
                  limitBudgetPlan: widget.limitAmount,
                  predictionAmount:
                      double.tryParse(limitAmountController.text) ?? 0.0,
                  dateReset: DateTime.now()),
              PlanPocketCreate(
                  iconData: IconConstants.icons[indexIcon],
                  isFullSize: true,
                  account: accountVisit,
                  planning: Planning.Details(
                      planId: 1,
                      name: !planingController.text.isEmpty
                          ? planingController.text
                          : "Planning",
                      limit: double.tryParse(limitAmountController.text) ?? 0.0,
                      indexIcon: indexIcon,
                      accountName: accountVisit?.accountName ?? "",
                      createDate: DateTime.now(),
                      updateDate: DateTime.now())),
              SizedBox(height: 24),
              GenericRow(genericWidgets: [
                GenericInputField(
                  controller: planingController,
                  labelText: "Plan Name",
                ),
                GenericInputField(
                    controller: limitAmountController,
                    isOnlyNumber: true,
                    labelText: "Limit"),
              ], gapSize: 24),
              SelectAllIcons(onIconSelected: handleIcon),
              SelectAllAccounts(
                  onAccountSelected: handleAccount, accountVisit: accountVisit),
              SizedBox(height: 24),
              GenericCreateBTN(
                  disable: false,
                  onPressed: () {
                    context.read<PlansBloc>().add((CreatePlanEvent(
                        planning: Planning.create(
                            name: planingController.text,
                            limit:
                                double.tryParse(limitAmountController.text) ??
                                    0.0,
                            indexIcon: indexIcon,
                            accountId: accountVisit?.accountId ?? -1))));
                  },
                  title: "Create Plan"),
            ],
          ),
        ),
      ),
    );
  }
}
