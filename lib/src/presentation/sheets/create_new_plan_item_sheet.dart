import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPlanItemSheet extends StatefulWidget {
  final int planId;

  const CreateNewPlanItemSheet({super.key, required this.planId});

  @override
  State<CreateNewPlanItemSheet> createState() => _CreateNewPlanItemSheetState();
}

class _CreateNewPlanItemSheetState extends State<CreateNewPlanItemSheet> {
  final String kTitle = "Create New Plan Item";
  final String kDesc =
      "Add a new item to your plan to better organize your budget.";

  late String iconName;
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Map<int, Widget> segmentOptions = const <int, Widget>{
    0: Text('Saving'),
    1: Text('Paid'),
  };

  @override
  void initState() {
    super.initState();
    iconName = "";

    amountController.addListener(_onFormChanged);
    planNameController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    amountController.dispose();
    planNameController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    setState(() {});
  }

  void handleSetIcon(String icon) {
    setState(() {
      iconName = icon;
    });
  }

  bool isFillNotCompletly() {
    final amountText = amountController.text.trim();
    final nameText = planNameController.text.trim();

    final double amount = double.tryParse(amountText) ?? 0;

    return amount <= 0 || nameText.isEmpty;
  }

  void saveNewPlanning(BuildContext context) {
    context.read<PlanItemBloc>().add(AddPlanItemEvent(
            planItemDto: PlanItemDto(
          planId: widget.planId,
          title: planNameController.text.trim(),
          planAmount: double.parse(amountController.text),
          category: "TRANFER",
          iconName: iconName,
        )));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.allxxl,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            _buildTiltleVreateNewPlan(),
            _buildCreatePlanAction(),
            const Spacer(),
            CustomCommonWidget.commonElevatedBtn(
              label: "Save",
              onPressed: () => saveNewPlanning(context),
              isDisable: isFillNotCompletly(),
            )
          ],
        ),
      ),
    );
  }

  Column _buildTiltleVreateNewPlan() {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          kTitle,
          style: AppTextStyles.headlineSmall,
        ),
        Text(
          kDesc,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.grayLight,
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

  Column _buildCreatePlanAction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        CustomCommonWidget.savingPaidSegment(
            initialSelectedIndex: 0, segmentOptions: segmentOptions),
        CustomCommonComponent.labelledIconRow(
            iconData: iconName, handleSelectIcon: handleSetIcon),
        CustomCommonComponent.labelledTextFieldRow(
            label: "Plan Name",
            textEditingController: planNameController,
            placeHolder: "Ex. Retirement Plan"),
        CustomCommonComponent.labelledTextFieldRow(
            label: "Aount Limit",
            textEditingController: amountController,
            placeHolder: "Ex. 500",
            isNumberOnly: true),
      ],
    );
  }
}
