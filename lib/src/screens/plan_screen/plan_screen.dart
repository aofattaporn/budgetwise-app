import 'package:budget_wise/src/constant/style/size.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const kSelectingMonth = "Selecting Month";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // selecccting month planning
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(kSelectingMonth),
            const SizedBox(width: SizeConstants.kSize4),
            TextButton(onPressed: () {}, child: const Text("Feb 2024"))
          ],
        ),

        // planing pocket
        Padding(
          padding: SizeConstants.kPadd15,
          child: Container(
            padding: SizeConstants.kPaddV16H4,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 2, // Controls the spread of the shadow
                    blurRadius: 5, // Controls how blurred the shadow is
                    offset: const Offset(0, 1),
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Section: Circular Dashboard

                Expanded(
                  flex: 5, // Controls the width ratio
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 0.6,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Usage : 50000 / 40000",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // Right Section: Budget Breakdown
                const Expanded(
                  flex: 4, // Controls the width ratio
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align items at the top
                    children: [
                      Text("Transfer : 5000 / 10000",
                          style: TextStyle(fontSize: 12)),
                      SizedBox(height: 4),
                      Text("Saving  : 5000 / 2000",
                          style: TextStyle(fontSize: 12)),
                      SizedBox(height: 4),
                      Text("Not Plan  : 4000 / 3000",
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

        // planing item on this month
      ],
    );
  }
}
