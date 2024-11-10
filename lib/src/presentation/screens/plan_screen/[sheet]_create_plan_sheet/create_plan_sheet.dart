import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_success.dart';
import 'package:budget_wise/src/presentation/ui/generic_input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_column.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/ui/generic_sheet.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket_create.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_icons/select_all_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/select_all_accounts/select_all_accounts.dart';

class CreatePlanSheet extends StatefulWidget {
  final bool isEdit;
  final PlanEntity? existingPlan;
  final DateTime monthYear;

  const CreatePlanSheet(
      {this.existingPlan,
      required this.isEdit,
      super.key,
      required this.monthYear});

  @override
  State<CreatePlanSheet> createState() => _CreatePlanSheetState();
}

class _CreatePlanSheetState extends State<CreatePlanSheet> {
  final TextEditingController limitAmountController = TextEditingController();
  final TextEditingController planingController = TextEditingController();

  BudgetAccountEntity? accountVisit;
  int indexIcon = 0;
  double litAmountMonthly = 0;
  double currentTotalUsage = 0;
  String toggleType = "";

  @override
  void initState() {
    super.initState();

    // get from local cache
    context.read<AccountBloc>().add(GetAllLocalAccountsEvent());
    context.read<UsersFinBloc>().add(GetData());
    context.read<PlansBloc>().add(GetCurrentSpendingEvent());

    if (widget.existingPlan != null) {
      planingController.text = widget.existingPlan!.name;
      limitAmountController.text = widget.existingPlan!.limit.toString();
      indexIcon = widget.existingPlan!.indexIcon;
      toggleType = widget.existingPlan!.type!;
    }

    planingController.addListener(() => setState(() {}));
    limitAmountController.addListener(() => setState(() {}));
  }

  void handleAccount(BudgetAccountEntity account) {
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

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    planingController.removeListener(_onTextChanged);
    limitAmountController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _handleEditPlan() {
    if (widget.isEdit) {
      _updatePlan();
    } else {
      _createPlan();
    }
  }

  void _updatePlan() {
    context.read<PlansBloc>().add(UpdatePlanEvent(
        planning: PlanEntity.update(
            planId: widget.existingPlan!.planId,
            name: planingController.text,
            limit: double.tryParse(limitAmountController.text) ?? 0.0,
            indexIcon: indexIcon,
            accountId: accountVisit!.accountId)));
  }

  void _createPlan() {
    context.read<PlansBloc>().add(CreatePlanEvent(
        planning: PlanEntity.create(
            name: planingController.text,
            type: toggleType,
            limit: double.tryParse(limitAmountController.text) ?? 0.0,
            indexIcon: indexIcon,
            accountId: accountVisit?.accountId ?? -1,
            month: widget.monthYear)));
  }

  @override
  Widget build(BuildContext context) {
    return GenericSheet(
      title: widget.isEdit ? 'Edit Plan' : 'Create Plan',
      widgets: [
        GenericColumn(gapSize: 16, genericWidgets: [
          BudgetLimitLabel(
              currentUsage: currentTotalUsage,
              limitBudgetPlan: litAmountMonthly,
              predictionAmount: double.tryParse(limitAmountController.text),
              monthYear: DateTime.now()),
          PlanPocketCreate(
              iconData: IconConstants.icons[indexIcon],
              isFullSize: true,
              account: accountVisit,
              planning: PlanEntity.details(
                  planId: 1,
                  usage: 0,
                  name: planingController.text.isNotEmpty
                      ? planingController.text
                      : "Planning",
                  limit: double.tryParse(limitAmountController.text) ?? 0.0,
                  indexIcon: indexIcon,
                  accountName: accountVisit?.accountName ?? "",
                  createDate: DateTime.now(),
                  updateDate: DateTime.now())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Planning Type : $toggleType'),
              Switch.adaptive(
                value: toggleType == "tranfers",
                onChanged: (newValue) {
                  setState(() {
                    toggleType = newValue ? "tranfers" : "saving";
                  });
                },
              ),
            ],
          ),
          GenericRow(gapSize: 24, genericWidgets: [
            GenericInputField(
              controller: planingController,
              labelText: "Plan Name",
            ),
            GenericInputField(
                controller: limitAmountController,
                isOnlyNumber: true,
                labelText: "Limit"),
          ]),
          SelectAllIcons(onIconSelected: handleIcon),
          SelectAllAccounts(
              onAccountSelected: handleAccount, accountVisit: accountVisit),
          GenericCreateBTN(
              disable: false,
              title: widget.isEdit ? 'Update Plan' : 'Create Plan',
              onPressed: _handleEditPlan),
        ]),
      ],
    );
  }
}
