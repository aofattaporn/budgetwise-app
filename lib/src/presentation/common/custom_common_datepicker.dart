import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:budget_wise/src/presentation/theme/system/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:flutter/material.dart';

class CustomCommonDatepicker extends StatefulWidget {
  const CustomCommonDatepicker({
    super.key,
    required this.label,
    required this.initialDate,
    this.onDateChanged,
  });

  final String label;
  final DateTime initialDate;
  final ValueChanged<DateTime>? onDateChanged;

  @override
  State<CustomCommonDatepicker> createState() => _CustomCommonDatepickerState();
}

class _CustomCommonDatepickerState extends State<CustomCommonDatepicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(widget.label, style: AppTextStyles.bodyMedium),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
            ),
            onPressed: () => _showDatePicker(context),
            child: Text(
              UtilsDateTime.dayMonthYearFormat(widget.initialDate),
              style: AppTextStyles.labelGraySmall,
            ),
          ),
        ),
      ],
    );
  }

  Theme datePickerTheme(Widget? child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.black,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      child: child!,
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return datePickerTheme(child);
      },
    );

    if (picked != null && picked != widget.initialDate) {
      widget.onDateChanged?.call(picked);
    }
  }
}
