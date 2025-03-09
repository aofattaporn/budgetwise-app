import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_bloc.dart';
import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_event.dart';
import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_state.dart';
import 'package:budget_wise/src/constant/business_constant.dart';
import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:budget_wise/src/widgets/DatePicker/date_picker.dart';
import 'package:budget_wise/src/widgets/TextField/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningDetail extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final double? amount;

  const PlanningDetail({
    super.key,
    this.startDate,
    this.endDate,
    this.amount,
  });

  @override
  State<PlanningDetail> createState() => _PlanningDetailState();
}

class _PlanningDetailState extends State<PlanningDetail> {
  @override
  void initState() {
    super.initState();
    context.read<PlanDetailBloc>().add(InitializePlanningDetailEvent(
        startDate: widget.startDate,
        endDate: widget.endDate,
        amount: TextEditingController(text: widget.amount?.toString() ?? '')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning Detail", style: TextStyles.size16w600),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      ),
      body: Padding(
        padding: SizeConstants.kPadd24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _blocCircleStatsWidget(),
            const SizedBox(height: 32),
            _blocStartDatePicker(context),
            const SizedBox(height: 10),
            _blocEndDatePicker(context),
            const SizedBox(height: 10),
            _blocAmount(context),
            const SizedBox(height: 32),
            _saveButton()
          ],
        ),
      ),
    );
  }

  BlocBuilder<PlanBloc, PlanState> _blocCircleStatsWidget() {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        if (state is GetPlanCurrentMonthSuccess) {
          return CircularStatsWidget(
            isLoanding: false,
            enableChangeMonth: true,
            startDate: state.planInfo.startDate,
            endDate: state.planInfo.endDate,
            usage: 500,
            amount: state.planInfo.totalBudget,
            percentage:
                (500 / state.planInfo.totalBudget) * CommonConstant.percentage,
          );
        } else {
          return CircularStatsWidget(
            isLoanding: true,
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            usage: 0,
            amount: 0,
            percentage: 0,
            enableChangeMonth: false,
          );
        }
      },
    );
  }

  BlocBuilder<PlanDetailBloc, PlanDetailState> _blocStartDatePicker(
      BuildContext context) {
    return BlocBuilder<PlanDetailBloc, PlanDetailState>(
      builder: (context, state) {
        return DatePicker(
          initialDate: state.startDate,
          label: CommonConstant.startDateLabel,
          onDateSelected: (newDate) {
            context.read<PlanDetailBloc>().add(UpdateStartDateEvent(newDate));
          },
        );
      },
    );
  }

  BlocBuilder<PlanDetailBloc, PlanDetailState> _blocEndDatePicker(
      BuildContext context) {
    return BlocBuilder<PlanDetailBloc, PlanDetailState>(
      builder: (context, state) {
        return DatePicker(
          initialDate: state.endDate,
          label: CommonConstant.endDateLabel,
          onDateSelected: (newDate) {
            context.read<PlanDetailBloc>().add(UpdateStartDateEvent(newDate));
          },
        );
      },
    );
  }

  BlocBuilder<PlanDetailBloc, PlanDetailState> _blocAmount(
      BuildContext context) {
    return BlocBuilder<PlanDetailBloc, PlanDetailState>(
      builder: (context, state) {
        return CustomTextField(
          controller: state.amount,
          placeholder: CommonConstant.enterCommonLabel,
          keyboardType: TextInputType.number,
          icon: CupertinoIcons.money_dollar,
        );
      },
    );
  }

  Widget _saveButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _savePlanning();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, // Remove default padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  ColorConstants.primary,
                  ColorConstants.primaryLigth,
                  ColorConstants.primarySubtle,
                ], // Purple gradient
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              width: double.infinity, // Full width
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }

  void _savePlanning() {
    const double amount = 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }
    Navigator.pop(context);
  }
}
