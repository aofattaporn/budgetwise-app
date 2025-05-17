import 'package:flutter/material.dart';

class PlanItemOverviewScreen extends StatelessWidget {
  const PlanItemOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.backspace_rounded))),
        body: Container());
  }
}
