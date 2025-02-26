import 'package:budget_wise/src/constant/business_constant.dart';
import 'package:budget_wise/src/utils/numbers_uti.dart';
import 'package:flutter/material.dart';

class AmountCompare extends StatelessWidget {
  final double amount;
  final double usage;

  const AmountCompare({super.key, required this.amount, required this.usage});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: Numbers.formatAmount(usage), // Make usage bold and larger
            style: TextStyle(
              fontSize: 14, // Bigger size
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.black, // Adjust color if needed
            ),
          ),
          TextSpan(
            text:
                "/ ${Numbers.formatAmount(amount)} ${BusinessConstant.BathUnit}",
            style: TextStyle(
              fontSize: 10, // Bigger size
              color: Colors.black, // Adjust color if needed
            ),
          ),
        ],
      ),
    );
  }
}
