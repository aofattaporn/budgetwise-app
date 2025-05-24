import 'package:budget_wise/src/presentation/screens/accounts/account_tab.dart';
import 'package:budget_wise/src/presentation/screens/main/sub_screens/home_tab.dart';
import 'package:budget_wise/src/presentation/screens/plans/plan_tab.dart';
import 'package:budget_wise/src/presentation/screens/main/sub_screens/transaction_tab.dart';
import 'package:budget_wise/src/presentation/widgets/bottomAppBar/custom_appbar.dart';
import 'package:budget_wise/src/presentation/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<ButtonNavigateProps> _tabProps = [
    ButtonNavigateProps(icon: Icons.home_work_outlined, label: "Home"),
    ButtonNavigateProps(icon: Icons.line_axis, label: "Transactions"),
    ButtonNavigateProps(icon: Icons.cloud, label: "Plan"),
    ButtonNavigateProps(icon: Icons.wallet, label: "Account"),
  ];

  Widget _getTabScreen(int index) {
    switch (index) {
      case 0:
        return const HomeTab();
      case 1:
        return const TypographyShowcaseScreen();
      case 2:
        return const PlanTab();
      case 3:
        return const AccountTab();
      default:
        return const Center(child: Text("Error: Unknown tab"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(top: false, child: _getTabScreen(_currentIndex)),
      floatingActionButton: CommonWidget.commonFloatingActionButton(
        onPressed: () {},
        icon: Icons.add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonWidget.commonBottomNavigateBar(
        currentIndex: _currentIndex,
        onTabChanged: (index) => setState(() => _currentIndex = index),
        btnProps: _tabProps,
      ),
    );
  }
}
