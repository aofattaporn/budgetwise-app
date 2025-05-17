import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/presentation/components/plan_item_card.dart';
import 'package:budget_wise/src/presentation/components/saving_slider.dart';
import 'package:budget_wise/src/presentation/components/segmented_circular_progress.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class PlanTab extends StatelessWidget {
  const PlanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.8,
            padding: const EdgeInsets.all(16),
            decoration: _buildBgBoxGradient(),
            child: Column(
              spacing: 36,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBudgetHeader(context),
                _buildBudgetOverview(context),
                _buildPlanItemSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetHeader(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const String kMessageHeader = "Monthly Budget";

    // TODO : Update time
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        SizedBox(height: screenHeight * 0.06), // 6% of screen
        Text(
          kMessageHeader,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.background),
        ),
        Row(
          spacing: 12,
          children: [
            const Icon(Icons.calendar_month_outlined,
                color: AppColors.background),
            Text(
              "${UtilsDateTime.monthYearFormat(now)} - ${UtilsDateTime.monthYearFormat(now)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.background),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBudgetOverview(BuildContext context) {
    return Row(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MultiSegmentCircularProgress(
          isNotfound: false,
          plan: null,
        ),
        Expanded(child: _buildBudgetDetail(context)),
      ],
    );
  }

  Widget _buildBudgetDetail(BuildContext context) {
    const String kMessageHeader = "budget usage";
    const String kMockUsage = "10,000";
    const String kAmountLimit = "30,000";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAmountRow(context, usage: kMockUsage),
        _buildAmountLimitText(context, kAmountLimit),
        const SizedBox(height: 12),
        Text(
          kMessageHeader,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.background),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        const SavingSlider(),
      ],
    );
  }

  Widget _buildAmountRow(BuildContext context, {required String usage}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        spacing: 12,
        children: [
          Text(
            usage,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.background),
          ),
          const Icon(
            Icons.edit,
            size: 24,
            color: AppColors.gray300,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountLimitText(BuildContext context, String amountLimit) {
    return Text(
      "/$amountLimit B",
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: AppColors.background),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPlanItemSection(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.25;

    return Expanded(
      child: Column(
        spacing: 14,
        children: [
          Row(
            children: [
              Text("Plan item List",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.background))
            ],
          ),
          SizedBox(
            height: cardHeight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => const PlanItemCard()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBgBoxGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary,
          AppColors.primaryDark,
        ],
      ),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24),
      ),
    );
  }
}
