import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/widgets/segment_control/segment_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:budget_wise/src/presentation/widgets/btn/common_elevated_btn.dart';

class CreateNewPlanItemSheet extends StatefulWidget {
  const CreateNewPlanItemSheet({super.key});

  @override
  State<CreateNewPlanItemSheet> createState() => _CreateNewPlanItemSheetState();
}

class _CreateNewPlanItemSheetState extends State<CreateNewPlanItemSheet> {
  final String kTitle = "Create New Plan Item";
  final String kDesc =
      "Add a new item to your plan to better organize your budget.";

  final TextEditingController iconController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Map<int, Widget> segmentOptions = const <int, Widget>{
    0: Text('Saving'),
    1: Text('Paid'),
  };

  void saveNewPlanning(BuildContext context) {
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
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 1,
            ),
            _buildCreatePlanAction(),
            const Spacer(),
            CommonElevatedBtn(
              label: "Save",
              onPressed: () => saveNewPlanning(context),
              isDisable: amountController.value.text == "",
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
      ],
    );
  }

  Column _buildCreatePlanAction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        CustomCommonWidget.savingPaidSegment(initialSelectedIndex: 0),
        CustomCommonComponent.labelledIconRow(
            label: "ICon",
            textEditingController: amountController,
            placeHolder: "Ex. 500"),
        CustomCommonComponent.labelledTextFieldRow(
            label: "Plan Name",
            textEditingController: amountController,
            placeHolder: "Ex. Retirement Plan"),
        CustomCommonComponent.labelledTextFieldRow(
            label: "Aount Limit",
            textEditingController: amountController,
            placeHolder: "Ex. 500"),
      ],
    );
  }
}
