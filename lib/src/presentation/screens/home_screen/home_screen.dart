import 'package:budget_wise/src/presentation/screens/home_screen/HorizontalScollviewAccounts/HorizaontalScollviewAccounts.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/HorizontalSrollViewOperations/HorizontalSrollViewOperations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = List<String>.generate(5, (i) => 'Item $i');

  var list = [
    "one",
    "two",
    "three",
    "four",
    "one",
    "two",
    "three",
    "four",
    "one",
    "two",
    "three",
    "four"
  ];

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalScollviewAccounts(),
            SizedBox(height: 10),
            HorizontalSrollViewOperations(),
            // SizedBox(height: 30),
            // VerticalScrollViewTodayTransaction(),
          ],
        ));
  }
}
