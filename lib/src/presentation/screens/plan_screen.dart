import 'package:flutter/widgets.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Plan',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
