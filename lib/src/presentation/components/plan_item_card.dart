import 'package:budget_wise/core/utils/numbers_uti.dart';
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
          height: 135,
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.background,
                    ),
                    child: Text(
                      planItemDto.iconName ?? "-",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.background),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        " ${NumberUtil.calPercentage(0, planItemDto.amountLimit).toString()} %",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: AppColors.background),
                      ),
                      Text(
                        "  used",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.background),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                planItemDto.name,
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
              SizedBox(
                width: double.infinity,
                height: 6,
                child: LinearProgressIndicator(
                  value: NumberUtil.calPercentage(0, planItemDto.amountLimit),
                  backgroundColor: AppColors.background,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryDark),
                ),
              ),
            ],
          ),
        ));
  }
}
