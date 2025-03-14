import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';

class MainScreenPlanTab extends StatelessWidget {
  const MainScreenPlanTab({super.key});

  List<TransactionsSegment> getMockTransactionSegment() {
    return [
      TransactionsSegment(
          segmentName: "tranfers", usage: 15000, color: AppColors.primary),
      TransactionsSegment(
          segmentName: "saving", usage: 1250, color: AppColors.primarySubtle),
      TransactionsSegment(
          segmentName: "not-plan", usage: 3000, color: AppColors.priamryDark)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: MultiSegmentCircularProgress(
                    size: 200,
                    strokeWidth: 10,
                    transactionsSegment: getMockTransactionSegment(),
                    limitSalary: 30000.00,
                  )),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: const Text("Tranfers",
                            style: TextStyle(color: AppColors.white))),
                    const Spacer(),
                    const AmountCompare(usage: 15000, limitAmount: 30000.00)
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primarySubtle,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: const Text("Saving",
                            style: TextStyle(color: AppColors.white))),
                    const Spacer(),
                    const AmountCompare(usage: 15000, limitAmount: 30000.00)
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.priamryDark,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: const Text("Not Plan",
                            style: TextStyle(color: AppColors.white))),
                    const Spacer(),
                    const AmountCompare(usage: 15000, limitAmount: 30000.00)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Text("List")))
        ],
      ),
    );
  }
}
