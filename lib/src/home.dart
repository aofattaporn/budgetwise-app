import 'package:budget_wise/src/presentation/constant/router.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/theme/shadow_theme.dart';
import 'package:flutter/material.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: const HomeScreen(),
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
                Navigator.pushNamed(context, AppRouter.home);
                break;
              case 1:
                Navigator.pushNamed(context, AppRouter.transaction);
                break;
              case 2:
                Navigator.pushNamed(context, AppRouter.plan);
                break;
            }
          },
        ),
      ),
    );
  }
}
