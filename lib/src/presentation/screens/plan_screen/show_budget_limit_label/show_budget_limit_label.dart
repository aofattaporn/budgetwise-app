import 'package:flutter/widgets.dart';

class BudgetLimitLabel extends StatelessWidget {
  const BudgetLimitLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
              child: Text("500/1500 B",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
          SizedBox(height: 12),
          Text("Date for Reset Budget plan 1 June 2024"),
          IntrinsicWidth(
              child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(240, 240, 240, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 12,
            width: MediaQuery.sizeOf(context).width,
          ))
        ],
      ),
    );
  }
}
