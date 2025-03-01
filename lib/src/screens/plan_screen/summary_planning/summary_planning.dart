import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/models/entity/plan_item.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';

class SummaryPlanning extends StatelessWidget {
  final List<PlanItem> planItem;
  final double totalBudget;
  const SummaryPlanning(
      {super.key, required this.planItem, required this.totalBudget});

  @override
  Widget build(BuildContext context) {
    final savingTotal = planItem
        .where((item) => item.category == "SAVING")
        .toList()
        .fold(0.0, (sum, item) => sum + item.usage);
    final tranferTotal = planItem
        .where((item) => item.category == "TRANFER")
        .toList()
        .fold(0.0, (sum, item) => sum + item.usage);
    final otherTotal = planItem
        .where((item) => item.category == "OTHER")
        .toList()
        .fold(0.0, (sum, item) => sum + item.usage);

    final List<Map<String, dynamic>> budgetItems = [
      {
        "title": "Saving",
        "color": ColorConstants.primaryLigth,
        "usage": savingTotal
      },
      {
        "title": "Transfers",
        "color": ColorConstants.primary,
        "usage": tranferTotal
      },
      {
        "title": "Other budget",
        "color": ColorConstants.priamryDark,
        "usage": otherTotal
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: SizeConstants.kRadius12,
      ),
      padding: SizeConstants.kPadd12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: budgetItems.map((item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryLabel(item["title"], item["color"]),
              AmountCompare(usage: item["usage"], amount: totalBudget),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryLabel(String title, Color color) {
    return Container(
      padding: SizeConstants.kPadd4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: SizeConstants.kRadius12,
      ),
      child: Text(title, style: const TextStyle(color: ColorConstants.white)),
    );
  }
}
