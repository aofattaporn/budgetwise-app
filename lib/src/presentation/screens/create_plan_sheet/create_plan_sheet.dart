import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/show_budget_limit_label/show_budget_limit_label.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_accounts/select_all_accounts.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_icons/select_all_icons.dart';
import 'package:flutter/material.dart';

class CreatePlanSheet extends StatefulWidget {
  const CreatePlanSheet({super.key});

  @override
  State<CreatePlanSheet> createState() => _CreatePlanSheetState();
}

class _CreatePlanSheetState extends State<CreatePlanSheet> {
  final TextEditingController planingController = TextEditingController();
  final TextEditingController limitAmountController = TextEditingController();
  Account? accountVisit = null;

  void handleAccount(Account account) {
    setState(() {
      accountVisit = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          children: [
            BudgetLimitLabel(),
            PlanPocket(
              isFullSize: true,
            ),
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
            SelectAllIcons(),
            SelectAllAccounts(
                onAccountSelected: handleAccount, accountVisit: accountVisit),
            SizedBox(height: 24),
            GenericCreateBTN(onPressed: () {}, title: "Create Plan"),
          ],
        ),
      ),
    );
  }
}
