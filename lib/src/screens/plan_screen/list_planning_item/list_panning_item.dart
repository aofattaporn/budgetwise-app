import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/widgets/TransferWidget/tranfer.dart';
import 'package:flutter/material.dart';

class ListPlanningItem extends StatelessWidget {
  const ListPlanningItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true, // Adjusts height automatically
          children: const [
            ExpenseItem(title: "Sport", percentage: 20, amount: 200),
            ExpenseItem(title: "Health", percentage: 15, amount: 150),
            ExpenseItem(title: "Grocery", percentage: 40, amount: 500),
            ExpenseItem(title: "Grocery", percentage: 40, amount: 500),
            ExpenseItem(title: "Grocery", percentage: 40, amount: 500),
            ExpenseItem(title: "Grocery", percentage: 40, amount: 500),
          ],
        ),
      ),
    );
  }
}
