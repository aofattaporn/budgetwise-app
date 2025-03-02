import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_state.dart';
import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/widgets/CircularStatsWidget/circular_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PlanningDetail extends StatefulWidget {
  const PlanningDetail({super.key});

  @override
  State<PlanningDetail> createState() => _PlanningDetailState();
}

class _PlanningDetailState extends State<PlanningDetail> {
  DateTime _startDate = DateTime(2024, 2, 1);
  DateTime _endDate = DateTime(2024, 2, 28);
  final TextEditingController _amountController = TextEditingController();

  void _showCupertinoDatePicker(BuildContext context, bool isStart) {
    DateTime tempDate = isStart ? _startDate : _endDate;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ปุ่ม Done
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(), // ทำให้ปุ่ม Done ไปอยู่ขวา
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (isStart) {
                          _startDate = tempDate;
                        } else {
                          _endDate = tempDate;
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Done", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: isStart ? _startDate : _endDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning List", style: TextStyles.size16w600),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      ),
      body: Padding(
        padding: SizeConstants.kPadd24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _blocCircleStatsWidget(),
            const SizedBox(height: SizeConstants.kSize24),

            // ปุ่มเลือกวันที่แบบ iOS
            GestureDetector(
              onTap: () => _showCupertinoDatePicker(context, true),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Start Date: ${DateFormat("dd MMM yyyy").format(_startDate)}",
                        style: const TextStyle(fontSize: 16)),
                    const Icon(CupertinoIcons.calendar),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => _showCupertinoDatePicker(context, false),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "End Date: ${DateFormat("dd MMM yyyy").format(_endDate)}",
                        style: const TextStyle(fontSize: 16)),
                    const Icon(CupertinoIcons.calendar),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            CupertinoTextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              placeholder: "Enter amount",
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(10),
              ),
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.money_dollar, color: Colors.black54),
              ),
              style: const TextStyle(fontSize: 16),
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
