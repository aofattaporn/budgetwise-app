import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/constant/style/size.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';

class SummaryPlanning extends StatelessWidget {
  const SummaryPlanning({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> budgetItems = [
      {
        "title": "Saving",
        "color": ColorConstants.primaryLigth,
        "usage": 5000.00
      },
      {"title": "Transfers", "color": ColorConstants.primary, "usage": 500.00},
      {
        "title": "Other budget",
        "color": ColorConstants.priamryDark,
        "usage": 500.00
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
              AmountCompare(usage: item["usage"], amount: 30000),
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
