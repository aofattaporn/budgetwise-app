import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:budget_wise/features/plan/data/models/plan_dto.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_event.dart';
import 'package:budget_wise/shared/common/custom_common_component.dart';
import 'package:budget_wise/shared/common/custom_common_dailog.dart';
import 'package:budget_wise/shared/common/custum_common_widget.dart';
import 'package:budget_wise/shared/components/segmented_circular_progress.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/shared/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PlanDetailScreen extends StatefulWidget {
  final PlanDto? planDto;

  const PlanDetailScreen({super.key, this.planDto});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  bool isButtonEnabled = false;
  late bool isNew;

  @override
  void initState() {
    super.initState();

    isNew = widget.planDto == null;
    if (!isNew) {
      final PlanDto existingPlane = widget.planDto!;
      planNameController.text = existingPlane.name;
      amountController.text = existingPlane.amountLimit.toString();
      startDateController.text =
          UtilsDateTime.dayMonthYearFormat(existingPlane.startDate);
      endDateController.text =
          UtilsDateTime.dayMonthYearFormat(existingPlane.endDate);
    }

    // Add listeners
    planNameController.addListener(_onInputChanged);
    amountController.addListener(_onInputChanged);
    startDateController.addListener(_onInputChanged);
    endDateController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    planNameController.dispose();
    amountController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  void _onClickCreatePlan(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy'); // must match UI format

    final parsedStart = formatter.parse(startDateController.text);
    final parsedEnd = formatter.parse(endDateController.text);

    context.read<PlanSelectorBloc>().add(InsertNewPlan(
          planDto: PlanDto(
            userId: UserUtil.aofUid(),
            name: planNameController.text,
            amountLimit: double.parse(amountController.text),
            startDate: parsedStart,
            endDate: parsedEnd,
            isArchived: false,
          ),
        ));

    Navigator.pop(context);
  }

  void _onClickEditPlan(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');

    final parsedStart = formatter.parse(startDateController.text);
    final parsedEnd = formatter.parse(endDateController.text);

    context.read<CurrentPlanBloc>().add(UpdateNewPlan(
          planDto: PlanDto(
            userId: UserUtil.aofUid(),
            id: widget.planDto!.id, // more id
            name: planNameController.text,
            amountLimit: double.parse(amountController.text),
            startDate: parsedStart,
            endDate: parsedEnd,
            isArchived: false,
          ),
        ));

    Navigator.pop(context);
  }

  void _onClickDeletePlan(BuildContext context) {
    CustomCommonDialog().confirmDeleteDialog(context,
        title: "Confirmation Delete",
        message: "Delte",
        onConfirm: () => {
              context
                  .read<CurrentPlanBloc>()
                  .add(DeletePlanById(planId: widget.planDto!.id!)),
              Navigator.pop(context)
            });
  }

  void _onInputChanged() {
    final isFilled = planNameController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty;

    if (isButtonEnabled != isFilled) {
      setState(() {
        isButtonEnabled = isFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context, screenHeight),
          _buildFormSection(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenHeight) {
    bool isPlanNew = (widget.planDto == null) ? true : false;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.4,
      padding: const EdgeInsets.only(top: 48, left: 18, right: 18),
      decoration: _buildBgBoxGradient(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.background,
                ),
              ),
              const Spacer(),
              !isPlanNew
                  ? IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.edit_square,
                        color: AppColors.background,
                      ),
                    )
                  : Container(),
              !isPlanNew
                  ? IconButton(
                      onPressed: () => _onClickDeletePlan(context),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: AppColors.background,
                      ),
                    )
                  : Container(),
            ],
          ),
          Center(
            child: MultiSegmentCircularProgress(
              isNotfound: true,
              plan: widget.planDto,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: planNameController,
              label: "Plan Name",
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: amountController,
              label: "Amount",
              isNumberOnly: true,
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labeledDatePickerRow(
              label: "Start Date",
              textEditingController: startDateController,
            ),
            const SizedBox(height: 12),
            CustomCommonComponent.labeledDatePickerRow(
              label: "End Date",
              textEditingController: endDateController,
            ),
            const SizedBox(height: 24),
            const Spacer(),
            isNew
                ? CustomCommonWidget.commonElevatedBtn(
                    isDisable: !isButtonEnabled,
                    label: "Create New",
                    onPressed: () => _onClickCreatePlan(context),
                  )
                : CustomCommonWidget.commonElevatedBtn(
                    isDisable: !isButtonEnabled,
                    label: "Update Now",
                    onPressed: () => _onClickEditPlan(context),
                  ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBgBoxGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      ),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24),
      ),
    );
  }
}
