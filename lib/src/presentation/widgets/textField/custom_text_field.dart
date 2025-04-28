import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeHolder;

  const CustomTextField({
    super.key,
    required this.placeHolder,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.dark),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        labelText: placeHolder,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w100,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
