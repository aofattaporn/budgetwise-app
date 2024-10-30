import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/bloc/users/users_bloc.dart';
import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:budget_wise/src/bloc/users/users_state.dart';
import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_success.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket_create.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_accounts/select_all_accounts.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_icons/select_all_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlanSheet extends StatefulWidget {
  final Planning? existingPlan;
  final bool isEdit;
  CreatePlanSheet({this.existingPlan, required this.isEdit, super.key});

  @override
  State<CreatePlanSheet> createState() => _CreatePlanSheetState();
}

class _CreatePlanSheetState extends State<CreatePlanSheet> {
  // local variable for manage data
  final planingController = TextEditingController();
  final TextEditingController limitAmountController = TextEditingController();
  Account? accountVisit = null;
  int indexIcon = 0;

  // variable retrive from blocs
  double litAmountMonthly = 0;
  double currentTotalUsage = 0;
  List<Account> accounts = [];

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
    context.read<AccountBloc>().add(GetAllLocalAccountsEvent());
    context.read<UsersFinBloc>().add(GetData());
    context.read<PlansBloc>().add(GetCurrentSpendingEvent());

    if (widget.existingPlan != null) {
      planingController.text = widget.existingPlan!.name;
      limitAmountController.text = widget.existingPlan!.limit.toString();
      indexIcon = widget.existingPlan!.indexIcon;
    }
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
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersFinBloc, UsersFinState>(
          listener: (BuildContext context, UsersFinState state) {
            if (state is GetSalaryAndMontYearSuccess) {
              setState(() {
                litAmountMonthly = state.data.salary;
              });
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (BuildContext context, AccountState state) {
            if (state is GetAllAccountsSuccess) {
              if (widget.existingPlan != null) {
                setState(() {
                  accountVisit = state.data.firstWhere((account) =>
                      account.accountName == widget.existingPlan!.accountName);
                });
              }
            }
          },
        ),
        BlocListener<PlansBloc, PlansState>(
            listener: (BuildContext context, state) {
          if (state is GetPlanSuccess) {
            setState(() {
              currentTotalUsage = state.totalPlanUsage;
            });
          }
          if (state is CreatePlanSuccess) {
            Navigator.pop(context);
          }
          if (state is UpdatePlanSuccess) {
            Navigator.pop(context);
          }
        })
      ],
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
                  currentUsage: currentTotalUsage,
                  limitBudgetPlan: litAmountMonthly,
                  predictionAmount:
                      double.tryParse(limitAmountController.text) ?? 0.0,
                  monthYear: DateTime.now()),
              PlanPocketCreate(
                  iconData: IconConstants.icons[indexIcon],
                  isFullSize: true,
                  account: accountVisit,
                  planning: Planning.Details(
                      planId: 1,
                      usage: 0,
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
                title: widget.isEdit ? "Update Plan" : "Create Plan",
                onPressed: () {
                  if (widget.isEdit) {
                    context.read<PlansBloc>().add((UpdatePlanEvent(
                        planning: Planning.update(
                            planId: widget.existingPlan!.planId,
                            name: planingController.text,
                            limit:
                                double.tryParse(limitAmountController.text) ??
                                    0.0,
                            indexIcon: indexIcon,
                            accountId: accountVisit!.accountId))));
                  } else {
                    context.read<PlansBloc>().add((CreatePlanEvent(
                        planning: Planning.create(
                            name: planingController.text,
                            limit:
                                double.tryParse(limitAmountController.text) ??
                                    0.0,
                            indexIcon: indexIcon,
                            accountId: accountVisit?.accountId ?? -1))));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
