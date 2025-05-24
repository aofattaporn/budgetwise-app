import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class PlanItemCard extends StatelessWidget {
  final PlanItemDto planItemDto;
  final double planBudgetLiit;
  const PlanItemCard({
    super.key,
    required this.planItemDto,
    required this.planBudgetLiit,
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
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    planItemDto.iconName ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.background),
                  ),
                  Text(
                    "4%",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: AppColors.background),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Food",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.background),
              ),
              const SizedBox(height: 2),
              Text(
                "0 / ${planItemDto.amountLimit} THB",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.background),
              ),
              const SizedBox(height: 6),
              const SizedBox(
                width: double.infinity,
                height: 6, // optional height
                child: LinearProgressIndicator(
                  value: 0.42,
                  backgroundColor: AppColors.background,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
                ),
              ),
            ],
          ),
        ));
  }
}
