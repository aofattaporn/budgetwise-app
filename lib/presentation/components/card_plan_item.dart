import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class CardPlan extends StatelessWidget {
  const CardPlan({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final headerHeight = screenHeight * 0.12;
    final cardWidth = screenWidth * 0.4;
    final cardHeight = screenHeight * 0.23;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.gray100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, headerHeight),
          const Spacer(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: height,
        color: Theme.of(context).primaryColor.withAlpha(200),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                Icons.home,
                size: 120,
                color: Theme.of(context).primaryColorDark.withAlpha(100),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Home",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: AppColors.background),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "B 30,000",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            "/20000",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.backgroundDark),
          ),
          LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(40),
            minHeight: 8,
            value: 0.5,
          ),
        ],
      ),
    );
  }
}
