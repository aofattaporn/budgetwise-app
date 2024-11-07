import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/widgets/plan_item/plan_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayPlansSuccess extends StatelessWidget {
  final List<PlanEntity> itemsTranfers;
  final List<PlanEntity> itemsSaving;

  const DisplayPlansSuccess(
      {super.key, required this.itemsTranfers, required this.itemsSaving});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saving Plan',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: itemsSaving.length,
                  itemBuilder: (context, index) {
                    return PlanItem(item: itemsSaving[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tranfer Plan',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: itemsTranfers.length,
                  itemBuilder: (context, index) {
                    return PlanItem(item: itemsTranfers[index]);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
