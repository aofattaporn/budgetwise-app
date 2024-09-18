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

class CreatePlanSheet extends StatefulWidget {
  const CreatePlanSheet({super.key});

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
            BudgetLimitLabel(salary: 200),
            PlanPocketCreate(
                iconData: IconConstants.icons[indexIcon],
                isFullSize: true,
                account: accountVisit,
                planning: Planning.create(
                  name: !planingController.text.isEmpty
                      ? planingController.text
                      : "Plannin",
                  limit: double.tryParse(limitAmountController.text) ?? 0.0,
                  indexIcon: indexIcon,
                  accountId: 0,
                )
                //   !planingController.text.isEmpty
                //       ? planingController.text
                //       : "Planning",
                //   double.tryParse(limitAmountController.text) ?? 0.0,
                //   0,
                // ),
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
            SelectAllIcons(onIconSelected: handleIcon),
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
