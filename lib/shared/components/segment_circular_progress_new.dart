import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:budget_wise/presentation/bloc/widget_state/widdgt_stat.dart';
import 'package:budget_wise/shared/components/circular_progression.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MultiSegmentCircularProgressNew extends StatelessWidget {
  final double size;
  final double strokeWidth;

  final BlocParentState blocParentState;
  final PlanMonthlyBudget? plan;

  const MultiSegmentCircularProgressNew({
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    this.plan,
    required this.blocParentState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // **
          // build background segment
          // **
          _buildBackgroundSegmment(),

          // **
          // build content plan segment
          // **

          if (blocParentState is BlocParentLoadingState)
            Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: AppColors.primary,
                size: 54,
              ),
            ),

          if (blocParentState is BlocParentStateComplete && plan != null)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),

          if (blocParentState is BlocParentErrorState)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Somthing went wrong",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryDark,
                      ),
                ),
                Text(
                  blocParentState is BlocParentErrorState
                      ? (blocParentState as BlocParentErrorState).message
                      : "Unknown error",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryDark,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Container _buildBackgroundSegmment() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(100)),
      child: const CircularProgression(
        size: 300,
        segmentUsages: [],
        segmentColors: [],
      ),
    );
  }
}
