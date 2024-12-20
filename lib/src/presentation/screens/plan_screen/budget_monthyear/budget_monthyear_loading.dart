import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BudgetLimitLabelLoading extends StatelessWidget {
  const BudgetLimitLabelLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            const Text('... / 2000 B',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 12),
            const Text("Date for Reset Budget plan 1 June 2024"),
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
      ),
    );
  }
}
