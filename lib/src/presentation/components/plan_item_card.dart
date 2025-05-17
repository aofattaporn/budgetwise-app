import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class PlanItemCard extends StatelessWidget {
  const PlanItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.height * 0.2;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryDark,
            spreadRadius: 2,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Text("26%",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.background)),
              ],
            ),
            const Icon(
              Icons.home_outlined,
              size: 36,
              color: AppColors.background,
            ),
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Eat sdfsdf",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppColors.background))
              ],
            ),
            Column(
              children: [
                _buildPlanItemDetail(context, "on usage", "20,000"),
                _buildPlanItemDetail(context, "on usage", "20,000"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanItemDetail(
      BuildContext context, String label, String value) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.background),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.background),
        )
      ],
    );
  }
}
