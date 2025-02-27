import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_event.dart';
import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_state.dart';
import 'package:budget_wise/src/constant/route_constant.dart';
import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:budget_wise/src/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/screens/transactions_screen/transactions_screen.dart';
import 'package:budget_wise/src/screens/unknow_screen/unknow_screen.dart';
import 'package:budget_wise/src/theme/shadow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _onTabScreen(String tabName) {
    switch (tabName) {
      case RouteConstant.home:
        return const HomeScreen();
      case RouteConstant.transaction:
        return const TransactionsScreen();
      case RouteConstant.plan:
        return const PlanScreen();
      default:
        return const UnknownScreen();
    }
  }

  int _onTabScreenInd(String tabName) {
    switch (tabName) {
      case RouteConstant.home:
        return 0;
      case RouteConstant.transaction:
        return 1;
      case RouteConstant.plan:
        return 2;
      default:
        return -1;
    }
  }

  String _onTabScreenStr(int ind) {
    switch (ind) {
      case 0:
        return RouteConstant.home;
      case 1:
        return RouteConstant.transaction;
      case 2:
        return RouteConstant.plan;
      default:
        return RouteConstant.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budgetwise screen", style: TextStyles.size16w600),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      ),
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return _onTabScreen(state.tabScreen);
        },
      ),
      bottomNavigationBar: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          int currentIndex = _onTabScreenInd(state.tabScreen);
          return Container(
            decoration: const BoxDecoration(
              boxShadow: [
                AppShadowTheme.lightShadow,
              ],
            ),
            child: BottomNavigationBar(
              elevation: 10,
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined),
                  label: RouteConstant.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.line_axis),
                  label: RouteConstant.transaction,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: RouteConstant.plan,
                ),
              ],
              selectedItemColor: Colors.purple,
              currentIndex: currentIndex,
              onTap: (index) {
                context
                    .read<MainScreenBloc>()
                    .add(TabScreenEvent(tabName: _onTabScreenStr(index)));
              },
            ),
          );
        },
      ),
    );
  }
}
