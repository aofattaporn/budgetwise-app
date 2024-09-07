import 'package:budget_wise/src/presentation/screens/home_screen/HorizontalScollviewAccounts/HorizaontalScollviewAccounts.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/HorizontalSrollViewOperations/HorizontalSrollViewOperations.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/VerticalScrollViewTodayTransaction/VerticalScrollViewTodayTransaction.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = List<String>.generate(5, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.none,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontalScollviewAccounts(),
          SizedBox(height: 10),
          HorizontalSrollViewOperations(),
          SizedBox(height: 30),
          VerticalScrollViewTodayTransaction(),
        ],
      ),
    ));
  }
}
