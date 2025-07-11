import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/presentation/components/card_plan_item.dart';
import 'package:flutter/material.dart';

class PlanAllItemScreen extends StatelessWidget {
  const PlanAllItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Plan Budget",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔒 Header fixed
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Plan Budget",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Create New Plan"),
                ),
              ],
            ),
          ),

          // 🔽 Scrollable grid below
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4 / 4,
                ),
                itemBuilder: (context, index) {
                  return CardPlan(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight * 0.8,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
