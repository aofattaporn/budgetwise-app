import 'package:flutter/material.dart';

class BudgetLimitLabelfailure extends StatelessWidget {
  const BudgetLimitLabelfailure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
              child: Text('Error Something went wrong',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))),
          SizedBox(height: 12),
          Text("Plas to try agains click"),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}