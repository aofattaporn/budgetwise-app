import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/models/entity/plan_item.dart';
import 'package:budget_wise/src/widgets/TransferWidget/tranfer.dart';
import 'package:flutter/material.dart';

class ListPlanningItem extends StatelessWidget {
  final List<PlanItem> planItem;

  const ListPlanningItem({
    super.key,
    required this.planItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: SizeConstants.kPadd12,
        child: ListView(
          shrinkWrap: true,
          children: planItem.map((item) {
            final percentage = (item.usage / item.planAmount);
            return ExpenseItem(
              title: item.title,
              percentage: percentage,
              amount: item.planAmount,
              usage: item.usage,
            );
          }).toList(),
        ),
      ),
    );
  }
}
