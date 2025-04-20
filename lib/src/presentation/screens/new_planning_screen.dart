import 'package:budget_wise/src/common/presentation/widgets/btn/common_elevated_btn.dart';
import 'package:budget_wise/src/core/constant/date_constant.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/common/presentation/custom_common_datepicker.dart';
import 'package:budget_wise/src/common/presentation/custom_common_text_field.dart';
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPlanningScreen extends StatefulWidget {
  final PlanDto? planDto;
  final int? id;

  const NewPlanningScreen({super.key, this.planDto = null, this.id = null});

  @override
  State<NewPlanningScreen> createState() => _NewPlanningScreenState();
}

class _NewPlanningScreenState extends State<NewPlanningScreen> {
  final TextEditingController amountController = TextEditingController();

  late bool isEditing;
  late DateTime startDate;
  late DateTime endDate;
  late double amount;
  late bool isSaveDisabled = true;

  final String kNewPlanning = 'New Planning';

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    isEditing = widget.planDto != null;

    final startDateThisMonth =
        DateTime(now.year, now.month, DateConstant.firstDayOfMonth);
    final endDateThisMonth = DateTime(now.year,
        now.month + DateConstant.firstDayOfMonth, DateConstant.lastDayOfMonth);

    startDate = isEditing ? widget.planDto!.startDate : startDateThisMonth;
    endDate = isEditing ? widget.planDto!.endDate : endDateThisMonth;

    amount = isEditing ? widget.planDto!.totalBudget : 0.0;
    amountController.text = amount == 0.0 ? '' : amount.toStringAsFixed(0);

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

  void saveNewPlanning(BuildContext context) {
    context.read<PlanAllMonthBloc>().add(AddNewPlan(
        planDto: PlanDto(
            startDate: startDate,
            endDate: endDate,
            totalBudget: double.parse(amountController.text.trim()))));
    Navigator.pop(context);
  }

  void editNewPlanning(
    BuildContext context,
  ) {
    context.read<PlanAllMonthBloc>().add(EditPlan(
        planDto: PlanDto(
            startDate: startDate,
            endDate: endDate,
            totalBudget: double.parse(amountController.text.trim())),
        id: widget.id!));
    Navigator.pop(context);
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
              isEditing
                  ? CommonElevatedBtn(
                      label: "Edit",
                      onPressed: () => editNewPlanning(context),
                      isDisable: amountController.value.text == "",
                    )
                  : CommonElevatedBtn(
                      label: "Save",
                      onPressed: () => saveNewPlanning(context),
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
