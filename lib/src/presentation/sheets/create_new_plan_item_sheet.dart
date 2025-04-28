import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';

class CreateNewPlanItemSheet extends StatefulWidget {
  const CreateNewPlanItemSheet({super.key});

  @override
  State<CreateNewPlanItemSheet> createState() => _CreateNewPlanItemSheetState();
}

class _CreateNewPlanItemSheetState extends State<CreateNewPlanItemSheet> {
  final TextEditingController iconController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  int selectedSegment = 0;
  final Map<int, Widget> segmentOptions = const <int, Widget>{
    0: Text('Saving'),
    1: Text('Paid'),
  };

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
          ],
        ),
      ),
    );
  }

  Column _buildTiltleVreateNewPlan() {
    return Column(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Create New Plan Item",
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: 8),

        // Sub description
        Text(
          "Add a new item to your plan to better organize your budget.",
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
        _buildSegmentedControl(),
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

  Widget _buildSegmentedControl() {
    return Container(
      width: double.infinity, // 👈 ทำให้เต็มความกว้าง
      padding: const EdgeInsets.symmetric(
          horizontal: 4, vertical: 4), // optional เพิ่มให้ดูเหมือน iOS จริงๆ
      decoration: BoxDecoration(
        color: AppColors.primarySubtle.withOpacity(0.2), // พื้นหลังนิดๆ
        borderRadius: BorderRadius.circular(24),
      ),
      child: CupertinoSegmentedControl<int>(
        children: segmentOptions,
        groupValue: selectedSegment,
        padding: const EdgeInsets.all(0),
        borderColor: AppColors.primary, // สีเส้นขอบ
        selectedColor: AppColors.primary, // สีพื้นหลังเมื่อเลือก
        unselectedColor: AppColors.white,
        pressedColor: AppColors.primarySubtle,
        onValueChanged: (int newValue) {
          setState(() {
            selectedSegment = newValue;
          });
        },
      ),
    );
  }
}
