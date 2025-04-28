import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/app_padding.dart';
import 'package:budget_wise/src/presentation/widgets/box_icon.dart';
import 'package:flutter/material.dart';

class CustomCommonWidget {
  const CustomCommonWidget._();

  static Widget boxIcon({
    required IconData iconData,
    double size = 20,
    Color backgroundColor = AppColors.primarySubtle,
    Color iconColor = AppColors.primaryDark,
    double borderRadius = 8,
    EdgeInsetsGeometry padding = AppPadding.allmd,
  }) {
    return BoxedIcon(
      iconData: iconData,
      size: size,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      borderRadius: borderRadius,
      padding: padding,
    );
  }
}
