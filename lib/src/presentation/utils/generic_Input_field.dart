import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GenericInputField extends StatelessWidget {
  final bool? isOnlyNumber;
  final bool? isDateFied;
  final String? labelText;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? hintText;
  final TextEditingController controller;
  final Widget? prefix;
  final bool? disable;

  GenericInputField({
    super.key,
    this.isDateFied,
    this.isOnlyNumber,
    this.labelText,
    this.suffixText,
    this.suffixIcon,
    this.maxLines,
    this.minLines,
    this.hintText,
    this.prefix,
    this.disable,
    required this.controller,
  }) {
    // Set the default value to today's date if it's a date field
    if (isDateFied == true) {
      controller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  Future<void> onTapDatePicker({
    required BuildContext context,
    required TextEditingController datePickerController,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? adjustedMinLines =
        (minLines != null && maxLines != null && minLines! > maxLines!)
            ? maxLines
            : minLines;

    return TextField(
      controller: controller,
      minLines: adjustedMinLines,
      maxLines: maxLines ?? 1,
      enabled: disable,
      readOnly: isDateFied == true,
      onTap: isDateFied == true
          ? () => onTapDatePicker(
              context: context, datePickerController: controller)
          : null,
      keyboardType: isOnlyNumber == true
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isOnlyNumber == true
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ]
          : null,
      decoration: InputDecoration(
          prefixIcon: prefix,
          hintText: hintText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: disable == true ? Colors.grey.shade100 : Colors.white,
          labelText: labelText,
          suffixText: suffixText,
          suffixIcon: suffixIcon),
      onChanged: (value) {
        if (isOnlyNumber == true) {
          String formattedValue = formatNumber(value);
          // Only update the text if the formatted value is different
          if (formattedValue != controller.text) {
            controller.text = formattedValue;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: formattedValue.length),
            );
          }
        }
      },
    );
  }

  String formatNumber(String value) {
    // Remove any non-numeric characters
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedValue.isEmpty) return '';

    final int parsedValue = int.parse(cleanedValue);
    // Format with commas
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(parsedValue);
  }
}
