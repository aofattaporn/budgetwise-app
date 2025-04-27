import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/app_colors.dart';

class CommonOutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? isDisable;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  static const Color defaultBackgroundColor = AppColors.primary;
  static const Color defaultTextColor = AppColors.white;

  const CommonOutlineBtn({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisable = true,
    this.backgroundColor = defaultBackgroundColor,
    this.textColor = defaultTextColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        textStyle: const TextStyle(fontSize: 10, color: defaultTextColor),
        foregroundColor: backgroundColor,
        side: BorderSide(color: backgroundColor ?? AppColors.primary),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
