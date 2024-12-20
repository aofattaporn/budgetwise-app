import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericTxtBTN extends StatelessWidget {
  String title;
  final VoidCallback handler;

  GenericTxtBTN({
    required this.title,
    required this.handler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextButton(
        onPressed: handler,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 168, 21, 194),
              fontWeight: FontWeight.bold),
          selectionColor: Colors.purple,
        ),
      ),
    );
  }
}
