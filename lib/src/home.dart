import 'package:budget_wise/src/presentation/constant/router.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
import 'package:budget_wise/src/presentation/theme/shadow_theme.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const TransactionsScreen(),
    const PlanScreen(),
  ];

  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            AppShadowTheme.lightShadow,
          ],
        ),
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_work_outlined),
              label: AppRouter.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.line_axis),
              label: AppRouter.transaction,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud), label: AppRouter.plan)
          ],
          selectedItemColor: Colors.purple,
          onTap: (index) {
            // Navigate based on the selected index
            switch (index) {
              case 0:
                setState(() {
                  _selectedIndex = 0;
                });
                break;
              case 1:
                setState(() {
                  _selectedIndex = 1;
                });
                break;
              case 2:
                setState(() {
                  _selectedIndex = 2;
                });
                break;
            }
          },
        ),
      ),
    );
  }
}
