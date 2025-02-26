import 'package:budget_wise/src/constant/style/colors.dart';
import 'package:budget_wise/src/widgets/AmountCompare/amount_compare.dart';
import 'package:flutter/material.dart';

class SummaryPlanning extends StatelessWidget {
  const SummaryPlanning({
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("Saving",
                        style: TextStyle(color: ColorConstants.white)),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: ColorConstants.primaryLigth,
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                AmountCompare(usage: 5000, amount: 30000),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("Tranfers",
                        style: TextStyle(color: ColorConstants.white)),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: ColorConstants.primary,
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                AmountCompare(usage: 500, amount: 30000),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("Other budget",
                        style: TextStyle(color: ColorConstants.white)),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: ColorConstants.priamryDark,
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                AmountCompare(usage: 500, amount: 30000),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
