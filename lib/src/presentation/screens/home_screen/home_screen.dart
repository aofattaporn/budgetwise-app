import 'package:budget_wise/src/presentation/screens/home_screen/show_allAccounts_homepage/show_all_accounts_homepage.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/show_operations_homepage/show_operations_homepage.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/show_today_transaction_homepage/show_today_transaction_homepage.dart';
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
        clipBehavior: Clip.none,
        child: Container(
          margin: const EdgeInsets.all(16),
          clipBehavior: Clip.none,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowAllAccountsHomepage(),
              SizedBox(height: 10),
              ShowOperationsHomepage(),
              SizedBox(height: 30),
              ShowTodayTransactionHomepage(),
            ],
          ),
        ));
  }
}
