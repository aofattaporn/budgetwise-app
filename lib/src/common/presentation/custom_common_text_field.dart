import 'package:flutter/material.dart';

class CustomCommonTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeHolder;
  const CustomCommonTextField(
      {super.key,
      required this.placeHolder,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelText: 'Enter Amount',
        border: OutlineInputBorder(),
      ),
    );
  }
}
