import 'package:budget_wise/presentation/sheets/select_transaction_type_screen.dart';
import 'package:budget_wise/shared/common/custom_common_sheet.dart';
import 'package:budget_wise/presentation/account_tab.dart';
import 'package:budget_wise/presentation/screens/sub_screens/home_tab.dart';
import 'package:budget_wise/presentation/screens/plan_tab.dart';
import 'package:budget_wise/presentation/screens/transaction_tab.dart';
import 'package:budget_wise/shared/widgets/bottomAppBar/custom_appbar.dart';
import 'package:budget_wise/shared/widgets/common_widget.dart';
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
        return const TransactionTab();
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
        onPressed: () {
          CustomCommonSheet(height: 0.95).open(
            context,
            widget: const SelectTransactionTypeScreen(),
          );
        },
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
