import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';

class AllPlansSheet extends StatefulWidget {
  const AllPlansSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllPlansSheetState createState() => _AllPlansSheetState();
}

class _AllPlansSheetState extends State<AllPlansSheet> {
  List<TransactionsSegment> getMockTransactionSegment() {
    return [
      TransactionsSegment(
        segmentName: BusinessConstant.tranfersType,
        usage: 20000.0,
        color: AppColors.priamryDark,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.savingType,
        usage: 4000.0,
        color: AppColors.primary,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.notPlanType,
        usage: 4000.0,
        color: AppColors.primarySubtle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          "All Plans",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildListItems(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppShadow.lg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plan ${index + 1}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Details about this plan...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Spacer(),
              Expanded(
                child: MultiSegmentCircularProgress(
                  size: 80,
                  strokeWidth: 6,
                  transactionsSegment: getMockTransactionSegment(),
                  limitSalary: 3000,
                  isSuccess: true,
                  isNotfound: false,
                  isShowMessage: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
