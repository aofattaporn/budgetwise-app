import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:flutter/material.dart';

class LabelledTextFieldRow extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String? placeholder;

  const LabelledTextFieldRow({
    super.key,
    required this.label,
    required this.textEditingController,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Text(label),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 7,
          child: CustomCommonWidget.textField(
            textEditingController: textEditingController,
            placeholder: placeholder ?? '',
          ),
        ),
      ],
    );
  }
}
