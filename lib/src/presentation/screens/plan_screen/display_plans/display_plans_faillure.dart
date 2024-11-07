import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayPlansFaillure extends StatelessWidget {
  const DisplayPlansFaillure({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      heightFactor: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
          ),
          Text("Sommething went wrong",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Please try again later"),
        ],
      ),
    );
  }
}
