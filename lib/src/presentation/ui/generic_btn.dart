import 'package:budget_wise/src/presentation/screens/create_account/create_account.dart';
import 'package:flutter/material.dart';

class GenericCreateBTN extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const GenericCreateBTN({
    super.key,
    required this.onPressed,
    required this.title,
  });

  static void TextCustom(BuildContext context) {
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF9379E0), // Purple shade
            Color(0xFFAE78D6), // Lighter purple
            Color(0xFFD780E1), // Pinkish purple
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return CreateAccount();
            },
          );
        },
        child: Text(
          "create account",
          style: TextStyle(fontSize: 12),
        ),
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed, // Use the passed function
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(147, 121, 224, 1),
                  Color.fromRGBO(174, 120, 214, 1),
                  Color.fromRGBO(215, 128, 225, 1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(minHeight: 50),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}