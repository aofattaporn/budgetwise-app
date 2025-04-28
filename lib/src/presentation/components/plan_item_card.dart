import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/components/amount_compare.dart';
import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

class PlanItemCard extends StatelessWidget {
  final PlanItemEntity item;
  final double progress;

  const PlanItemCard({
    super.key,
    required this.item,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primarySubtle.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),
          const SizedBox(height: 12),
          CustomCommonWidget.progressBar(progress: progress)
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleAndUsage(),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // TODO: Implement more options
          },
        ),
      ],
    );
  }

  Widget _buildTitleAndUsage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          spacing: 12,
          children: [
            CustomCommonWidget.boxIcon(iconData: Icons.add_business_outlined),
            const SizedBox(width: 12),
            Text(
              item.title,
              style: AppTextStyles.headlineSmall,
            ),
          ],
        ),
        AmountCompare(usage: item.usage, limitAmount: item.planAmount),
      ],
    );
  }
}
