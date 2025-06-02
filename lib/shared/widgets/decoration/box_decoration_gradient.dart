import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class BoxDecorationGradient {
  static const BoxDecoration gradientBottomRounded = BoxDecoration(
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
