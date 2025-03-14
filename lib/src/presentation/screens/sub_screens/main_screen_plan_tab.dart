import 'package:flutter/material.dart';

class MainScreenPlanTab extends StatelessWidget {
  const MainScreenPlanTab({super.key});

  // 1. Get Sallary from current month
  // 2. handle plan loading
  // 3. summary usage for this month

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Column(
        children: [
          Center(child: Text("Display Planning")),
          Text("PlanScreen"),
        ],
      ),
    );
  }
}
