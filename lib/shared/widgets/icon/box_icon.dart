import 'package:budget_wise/shared/theme/system/app_colors.dart';
import 'package:budget_wise/shared/theme/system/app_padding.dart';
import 'package:flutter/material.dart';

class BoxedIcon extends StatelessWidget {
  final IconData iconData;

  final double size;
  final Color iconColor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const BoxedIcon({
    super.key,
    required this.iconData,
    this.size = 20,
    this.iconColor = AppColors.primaryDark,
    this.backgroundColor = AppColors.black,
    this.borderRadius = 8,
    this.padding = AppPadding.allmd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        iconData,
        size: size,
        color: iconColor,
      ),
    );
  }
}
