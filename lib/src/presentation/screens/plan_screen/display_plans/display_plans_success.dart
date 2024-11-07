import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/widgets/plan_item/plan_item.dart';
import 'package:flutter/material.dart';

class DisplayPlansSuccess extends StatelessWidget {
  final List<PlanEntity> itemsTranfers;
  final List<PlanEntity> itemsSaving;

  const DisplayPlansSuccess(
      {super.key, required this.itemsTranfers, required this.itemsSaving});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlanContainer(
          title: 'Saving Plan',
          titleColor: Colors.green,
          items: itemsSaving,
          heightFactor: 0.2,
        ),
        PlanContainer(
          title: 'Tranfer Plan',
          titleColor: Colors.red,
          items: itemsTranfers,
          heightFactor: 0.3,
        ),
      ],
    );
  }
}

class PlanContainer extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<PlanEntity> items;
  final double heightFactor;

  const PlanContainer({
    super.key,
    required this.title,
    required this.titleColor,
    required this.items,
    required this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * heightFactor,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: items.isEmpty
            ? const Color.fromARGB(
                255, 235, 237, 241) // Light gray background for an empty state
            : Colors.white, // White background when items are present
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(
                0, 0, 0, 0.08), // Softer shadow for a subtle effect
            blurRadius: 15, // Reduced blur radius for lighter shadow
            offset: Offset(0, 4), // Slight elevation effect
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
                  color: items.isEmpty
                      ? const Color.fromARGB(255, 191, 190, 190)
                      : titleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            _displayPlanItemEmpty()
          else
            _displayPlanItem(items)
        ],
      ),
    );
  }

  Widget _displayPlanItem(List<PlanEntity> item) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PlanItem(item: items[index]);
        },
      ),
    );
  }

  Widget _displayPlanItemEmpty() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Text(
              'No Plan Found',
              style: TextStyle(
                color: Color.fromARGB(255, 230, 230, 230),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Please add a new plan to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 204, 204, 204),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
