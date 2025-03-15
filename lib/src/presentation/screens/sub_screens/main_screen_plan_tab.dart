import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_radaius.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/core/utils/numbers_uti.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';

/// The main screen tab for displaying a plan-related view.
///
/// This widget displays various components, including:
/// - A segmented circular progress bar showing the usage of different segments.
/// - A summary container showing the details of transaction segments like "Transfers", "Savings", etc.
/// - A placeholder for a list of items related to the plan.
class MainScreenPlanTab extends StatelessWidget {
  const MainScreenPlanTab({super.key});

  /// Mock data for transaction segments.
  ///
  /// Returns a list of transaction segments, each containing:
  /// - `segmentName`: Name of the segment.
  /// - `usage`: The amount used in that segment.
  /// - `color`: The color representing the segment.
  ///
  /// This is just a mock method for demonstration purposes.
  List<TransactionsSegment> getMockTransactionSegment() {
    return [
      TransactionsSegment(
          segmentName: BusinessConstant.tranfersType,
          usage: 15000,
          color: AppColors.priamryDark),
      TransactionsSegment(
          segmentName: BusinessConstant.savingType,
          usage: 1250,
          color: AppColors.primary),
      TransactionsSegment(
          segmentName: BusinessConstant.notPlanType,
          usage: 200,
          color: AppColors.primarySubtle),
    ];
  }

  /// Mock method for the amount limit.
  ///
  /// Returns a mock amount limit of 30,000.00, representing the budget limit.
  /// This method is a placeholder for the actual logic.
  double getMockAmountLimit() {
    return 30000.00;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        children: [
          /// Container displaying a segmented circular progress bar.
          ///
          /// This container contains a circular progress bar that visualizes the
          /// distribution of the transaction segments against the budget limit.
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: MultiSegmentCircularProgress(
                size: 200,
                strokeWidth: 10,
                transactionsSegment: getMockTransactionSegment(),
                limitSalary: getMockAmountLimit(),
              ),
            ),
          ),

          /// Container displaying the summary of the transaction segments.
          ///
          /// This container lists the transaction segments with their usage and
          /// the budget limit.
          /// Each segment displays the name, usage, and how much of the budget
          /// is used.
          Container(
            width: double.infinity,
            padding: AppPadding.allmd,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(AppRadius.md),
              boxShadow: AppShadow.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children:
                  List.generate(getMockTransactionSegment().length, (index) {
                return SummaryPlanSegment(
                  segmentTilel: getMockTransactionSegment()[index].segmentName,
                  usage: getMockTransactionSegment()[index].usage,
                  limitAmount: getMockAmountLimit(),
                  segmentColor: getMockTransactionSegment()[index].color,
                );
              }),
            ),
          ),

          /// Expanded container displaying a placeholder for a list of items.
          ///
          /// This container currently holds a placeholder text "List". In a real
          /// implementation, it can be replaced with a list of items related to the plan.
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Text("List"), // Placeholder for a list of items
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryPlanSegment extends StatelessWidget {
  final String segmentTilel;
  final double usage;
  final double limitAmount;
  final Color segmentColor;
  const SummaryPlanSegment({
    super.key,
    required this.segmentTilel,
    required this.usage,
    required this.limitAmount,
    required this.segmentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: segmentColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(segmentTilel,
                style: const TextStyle(color: AppColors.white))),
        Text('(${NumberUtil.calPercentage(usage, limitAmount).toString()}%)',
            style: AppTextStyles.labelGraySmall),
        const Spacer(),
        AmountCompare(usage: usage, limitAmount: limitAmount)
      ],
    );
  }
}
