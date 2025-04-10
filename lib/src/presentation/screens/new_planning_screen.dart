import 'package:budget_wise/src/common/presentation/custom_common_datepicker.dart';
import 'package:budget_wise/src/common/presentation/custom_common_text_field.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';

class NewPlanningScreen extends StatefulWidget {
  const NewPlanningScreen({super.key});

  @override
  State<NewPlanningScreen> createState() => _NewPlanningScreenState();
}

class _NewPlanningScreenState extends State<NewPlanningScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TextEditingController amountController = TextEditingController();

  final String kNewPlanning = 'New Planning';

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
              _buildPlanningComponent(),
              const SizedBox(height: 16),
              CustomCommonDatepicker(
                label: 'Select Date',
                initialDate: startDate,
                onDateChanged: _onStartDateChanged,
              ),
              CustomCommonDatepicker(
                label: 'End Date',
                initialDate: endDate,
                onDateChanged: _onEndDateChanged,
              ),
              const SizedBox(height: 8),
              _buildAmountInputRow(),
              const SizedBox(height: 16),
              const Spacer(),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInputRow() {
    return Row(
      children: [
        const Expanded(
          child: Text('Amount', style: AppTextStyles.bodyMedium),
        ),
        Expanded(
            child: CustomCommonTextField(
          textEditingController: amountController,
          placeHolder: 'amount',
        )),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
        ),
        onPressed: () {
          print("Amount: ${amountController.text}");
        },
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildPlanningComponent() {
    return Container(
      padding: AppPadding.allxl,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadow.lg,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Spacer(),
          Expanded(
            child: MultiSegmentCircularProgress(
              size: 80,
              strokeWidth: 6,
              isShowMessage: false,
              plan: null,
            ),
          ),
        ],
      ),
    );
  }
}
