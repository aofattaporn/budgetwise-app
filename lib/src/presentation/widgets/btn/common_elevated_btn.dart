import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';

class CommonElevatedBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? isDisable;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const CommonElevatedBtn({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisable = true,
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisable ?? false;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? AppColors.primary.withOpacity(0.4)
              : backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: disabled ? 0 : null,
        ),
        child: Text(label),
      ),
    );
  }
}
