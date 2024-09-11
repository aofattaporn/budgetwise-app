import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GenericInputField extends StatelessWidget {
  final bool? isOnlyNumber;
  final bool? isDateField;
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
    this.isDateField,
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
    if (isDateField == true) {
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
      enabled: disable == null ? true : !disable!,
      readOnly: isDateField == true,
      onTap: isDateField == true
          ? () => onTapDatePicker(
              context: context, datePickerController: controller)
          : null,
      keyboardType: isOnlyNumber == true
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isOnlyNumber == true
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              // This allows numbers with a decimal point, but does not restrict the decimal places
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
        suffixIcon: suffixIcon,
      ),
      onChanged: (value) {
        if (isOnlyNumber == true) {
          String formattedValue = formatNumber(value);
          // Only update the text if the formatted value is different
          if (formattedValue != controller.text) {
            controller.value = TextEditingValue(
              text: formattedValue,
              selection: TextSelection.collapsed(offset: formattedValue.length),
            );
          }
        }
      },
    );
  }

  String formatNumber(String value) {
    // Remove any non-digit or non-decimal point characters
    String cleanedValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    if (cleanedValue.isEmpty) return '';

    // Split into integer and decimal parts
    List<String> parts = cleanedValue.split('.');

    // Keep the integer part as-is without formatting into thousands
    String integerPart = parts[0];

    // If there's a decimal part, return the combined result, otherwise return just the integer part
    if (parts.length > 1) {
      return '$integerPart.${parts[1]}'; // Keep the decimal part as it is, no length limitation
    }

    return integerPart;
  }
}
