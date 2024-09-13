import 'package:budget_wise/src/presentation/screens/create_account/create_account.dart';
import 'package:flutter/material.dart';

class GenericTxtBTN extends StatelessWidget {
  const GenericTxtBTN({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
