import 'package:budget_wise/src/common/presentation/widgets/common_elevated_btn.dart';
import 'package:budget_wise/src/core/constant/date_constant.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/common/presentation/custom_common_datepicker.dart';
import 'package:budget_wise/src/common/presentation/custom_common_text_field.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';

class NewPlanningScreen extends StatefulWidget {
  const NewPlanningScreen({super.key});

  @override
  State<NewPlanningScreen> createState() => _NewPlanningScreenState();
}

class _NewPlanningScreenState extends State<NewPlanningScreen> {
  final TextEditingController amountController = TextEditingController();

  late DateTime startDate;
  late DateTime endDate;
  late bool isSaveDisabled = true;

  final String kNewPlanning = 'New Planning';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    startDate = DateTime(now.year, now.month, DateConstant.firstDayOfMonth);
    endDate = DateTime(now.year, now.month + DateConstant.firstDayOfMonth,
        DateConstant.lastDayOfMonth);

    amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    setState(() {
      isSaveDisabled = amountController.text.trim().isEmpty;
    });
  }

  void _onStartDateChanged(DateTime newDate) {
    setState(() {
      startDate = newDate;
    });
  }

  void _onEndDateChanged(DateTime newDate) {
    setState(() {
      endDate = newDate;
    });
  }

  void _saveNewPlanning() {
    print("Start Date: $startDate");
    print("End Date: $endDate");
    print("Amount: ${amountController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(kNewPlanning),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.allxxl,
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomCommonDatepicker(
                label: 'Start Date',
                initialDate: startDate,
                onDateChanged: _onStartDateChanged,
              ),
              CustomCommonDatepicker(
                label: 'End Date',
                initialDate: endDate,
                onDateChanged: _onEndDateChanged,
              ),
              const SizedBox(height: 8),
              _buildAmountInput(),
              const SizedBox(height: 16),
              const Spacer(),
              CommonElevatedBtn(
                label: "Save",
                onPressed: _saveNewPlanning,
                isDisable: amountController.value.text == "",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Row(
      children: [
        const Expanded(
          child: Text('Amount', style: AppTextStyles.bodyMedium),
        ),
        Expanded(
          child: CustomCommonTextField(
            textEditingController: amountController,
            placeHolder: 'amount',
          ),
        ),
      ],
    );
  }
}
