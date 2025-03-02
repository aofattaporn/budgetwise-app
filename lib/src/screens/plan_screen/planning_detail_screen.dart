import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:budget_wise/src/widgets/DatePicker/date_picker.dart';
import 'package:budget_wise/src/widgets/TextField/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningDetail extends StatefulWidget {
  const PlanningDetail({super.key});

  @override
  State<PlanningDetail> createState() => _PlanningDetailState();
}

class _PlanningDetailState extends State<PlanningDetail> {
  DateTime _startDate = DateTime(2024, 2, 1);
  DateTime _endDate = DateTime(2024, 2, 28);
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning Datail", style: TextStyles.size16w600),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      ),
      body: Padding(
        padding: SizeConstants.kPadd24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _blocCircleStatsWidget(),
            const SizedBox(height: SizeConstants.kSize24),
            DatePicker(
              initialDate: _startDate,
              label: "Start Date",
              onDateSelected: (newDate) {
                setState(() {
                  _startDate = newDate;
                });
              },
            ),
            const SizedBox(height: 10),
            DatePicker(
              initialDate: _endDate,
              label: "End  Date",
              onDateSelected: (newDate) {
                setState(() {
                  _endDate = newDate;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _amountController,
              placeholder: "Enter amount",
              keyboardType: TextInputType.number,
              icon: CupertinoIcons.money_dollar,
            ),
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
}
