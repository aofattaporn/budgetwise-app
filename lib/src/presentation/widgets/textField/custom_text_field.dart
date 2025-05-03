import 'package:budget_wise/src/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeHolder;
  final bool isNumberOnly;

  const CustomTextField({
    super.key,
    required this.placeHolder,
    required this.textEditingController,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: isNumberOnly
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isNumberOnly
          ? [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'), // รองรับทศนิยม 2 ตำแหน่ง
              ),
            ]
          : [],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.dark,
      ),
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
        suffixIcon: isNumberOnly
            ? const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  '฿',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
