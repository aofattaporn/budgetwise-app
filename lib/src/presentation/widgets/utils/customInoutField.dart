import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? labelText;
  final int? maxLines;
  final int? minLines;
  final String? suffixText;

  const CustomInputField({
    super.key,
    this.labelText,
    this.suffixText,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure minLines is not greater than maxLines
    final int? adjustedMinLines =
        (minLines != null && maxLines != null && minLines! > maxLines!)
            ? maxLines
            : minLines;

    return TextField(
      minLines: adjustedMinLines,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        suffixText: suffixText,
      ),
    );
  }
}
