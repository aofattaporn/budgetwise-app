import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SavingSlider extends StatefulWidget {
  const SavingSlider({super.key});

  @override
  State<SavingSlider> createState() => _SavingSliderState();
}

class _SavingSliderState extends State<SavingSlider> {
  final PageController _controller = PageController(viewportFraction: 0.78);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> savings =
        List.generate(5, (index) => _buildSavingCard(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          child: PageView.builder(
            controller: _controller,
            itemCount: savings.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: savings[index],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: SmoothPageIndicator(
            controller: _controller,
            count: savings.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Colors.grey.shade300,
              dotHeight: 6,
              dotWidth: 6,
              spacing: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Saving",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.background)),
              Text("20%",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.background)),
            ],
          ),
          const SizedBox(height: 2),
          Text("20,000 / 50,000",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.gray200)),
        ],
      ),
    );
  }
}

final PageController _controller = PageController(viewportFraction: 0.78);
int _currentPage = 0;

@override
Widget build(BuildContext context) {
  final List<Widget> savings =
      List.generate(5, (index) => _buildSavingCard(context));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 80,
        child: PageView.builder(
          controller: _controller,
          itemCount: savings.length,
          onPageChanged: (index) {
            // setState(() {
            //   _currentPage = index;
            // });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: savings[index],
            );
          },
        ),
      ),
      const SizedBox(height: 12),
      Center(
        child: SmoothPageIndicator(
          controller: _controller,
          count: savings.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Theme.of(context).primaryColor,
            dotColor: Colors.grey.shade300,
            dotHeight: 6,
            dotWidth: 6,
            spacing: 6,
          ),
        ),
      ),
    ],
  );
}

Widget _buildSavingCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Saving",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.background)),
            Text("20%",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.background)),
          ],
        ),
        const SizedBox(height: 2),
        Text("20,000 / 50,000",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.gray200)),
      ],
    ),
  );
}
