import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:flutter/material.dart';

class LabelledTextFieldRow extends StatelessWidget {
  // mandatories paramm
  final String label;
  final TextEditingController textEditingController;

  // optional paramm
  final bool isNumberOnly;

  final String? placeholder;
  final int flexLabel;
  final int flexInput;
  final double spacing;

  const LabelledTextFieldRow({
    super.key,
    required this.label,
    required this.textEditingController,
    this.placeholder,
    this.flexLabel = 3,
    this.flexInput = 7,
    this.spacing = 16,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: spacing,
      children: [
        Flexible(
          flex: flexLabel,
          child: Text(label),
        ),
        Flexible(
          flex: flexInput,
          child: CustomCommonWidget.textField(
            textEditingController: textEditingController,
            placeholder: placeholder ?? '',
            isNumberOnly: isNumberOnly,
          ),
        ),
      ],
    );
  }
}
