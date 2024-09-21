import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/Numbers.dart';
import 'package:budget_wise/src/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';

class PlanPocket extends StatelessWidget {
  final Planning planning;
  final bool isFullSize;

  PlanPocket({
    required this.isFullSize,
    required this.planning,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(3, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: isFullSize ? 58 : 36,
                width: isFullSize ? 58 : 36,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(IconConstants.icons[planning.indexIcon],
                    color: Colors.grey, size: isFullSize ? 32 : 20),
              ),
              const SizedBox(width: 10),

              // Wrap the Column in Flexible to prevent overflow
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planning.name,
                      style: TextStyle(
                        fontSize: isFullSize ? 20 : 14,
                        fontWeight: isFullSize ? FontWeight.bold : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      planning.accountName,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text.rich(
                  TextSpan(
                    text: '${Strings.normalizeNumber(500.toString())}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '/ ${Strings.normalizeNumber(planning.limit.toString())} B',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ProgressBar(
                // convert percentage -> normalize [0, 1]
                progress: Numbers.calPercentage(500, planning.limit) / 100,
                isFullSize: false,
              )
            ],
          ),
        ],
      ),
    );
  }
}
