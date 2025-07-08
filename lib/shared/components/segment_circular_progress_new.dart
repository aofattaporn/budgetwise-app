import 'package:budget_wise/core/errors/error_object.dart';
import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:budget_wise/shared/components/circular_progression.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MultiSegmentCircularProgressNew extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final bool isError;
  final ErrorObject errorObject;

  final bool isLoaded;
  final bool isLoading;
  final bool isNotfound;

  final PlanMonthlyBudget? plan;

  const MultiSegmentCircularProgressNew({
    required this.errorObject,
    super.key,
    this.size = 200,
    this.strokeWidth = 10,
    this.isLoading = true,
    this.isError = true,
    this.isNotfound = false,
    this.plan,
    required this.isLoaded,
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

          if (isLoading)
            Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: AppColors.primary,
                size: 54,
              ),
            ),

          if (errorObject.isError)
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
                  errorObject.message ?? "Unknown error",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryDark,
                      ),
                ),
              ],
            ),

          if (isLoaded)
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
                  errorObject.message ?? "Unknown error",
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
