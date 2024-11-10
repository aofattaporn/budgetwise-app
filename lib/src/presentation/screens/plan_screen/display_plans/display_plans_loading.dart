import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DisplayPlansLoading extends StatelessWidget {
  const DisplayPlansLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PlanContainer(
          title: 'Saving Plan',
          titleColor: Colors.green,
          heightFactor: 0.2,
        ),
        PlanContainer(
          title: 'Transfer Plan',
          titleColor: Colors.red,
          heightFactor: 0.3,
        ),
      ],
    );
  }
}

class PlanContainer extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double heightFactor;

  const PlanContainer({
    super.key,
    required this.title,
    required this.titleColor,
    required this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * heightFactor,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Adjust number of skeleton items as needed
                itemBuilder: (context, index) {
                  return const SkeletonItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonItem extends StatelessWidget {
  const SkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
