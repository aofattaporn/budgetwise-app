import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/constant/textstyle.dart';
import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/numbers_uti.dart';
import 'package:flutter/material.dart';

class PlanItem extends StatelessWidget {
  final PlanEntity item;
  const PlanItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(240, 240, 240, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(IconConstants.icons[item.indexIcon],
                  color: Colors.grey, size: 20),
            ),
            const SizedBox(width: 10),
            TextValue().withText(item.name).getFont16BoldBlack().build(),
            const SizedBox(width: 10),
            const Text('2000/ 5000'),
          ],
        ),
        const SizedBox(height: 10),
        ProgressBar(
          progress: Numbers.calPercentage(200, 1000) / 100,
          isFullSize: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
