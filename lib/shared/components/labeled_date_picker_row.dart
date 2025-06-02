import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:flutter/material.dart';

class LabeledDatePickerRow extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;

  final String? placeholder;
  final int flexLabel;
  final int flexInput;
  final double spacing;

  const LabeledDatePickerRow({
    super.key,
    required this.label,
    required this.textEditingController,
    this.placeholder,
    this.flexLabel = 3,
    this.flexInput = 6,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: flexLabel,
          child: Text(label),
        ),
        Flexible(
          flex: flexInput,
          child: GestureDetector(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                final formattedDate =
                    UtilsDateTime.dayMonthYearFormat(pickedDate);
                textEditingController.text = formattedDate;
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: placeholder ?? 'Select date',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
