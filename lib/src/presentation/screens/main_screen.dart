// presentation/screens/main_screen.dart
import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/core/utils/strings_util.dart';
import 'package:budget_wise/src/domain/usecase/tab_screen_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_event.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_state.dart';
import 'package:budget_wise/src/core/constant/route_constant.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/main_screen_account_tab.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/plan_tab.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/main_screen_transaction_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabScreenUseCase = TabScreenUseCase();
    List<BottomNavigationBarItem> navBarItems() {
      return [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_work_outlined),
          label: StringUtil.replacePath(RouteConstant.home),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.line_axis),
          label: StringUtil.replacePath(RouteConstant.transaction),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.cloud),
          label: StringUtil.replacePath(RouteConstant.plan),
        ),
      ];
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return Scaffold(body: _onTabScreen(state.tabScreen));
        },
      ),
      bottomNavigationBar: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: 40,
            backgroundColor: AppColors.white,
            currentIndex: tabScreenUseCase.getTabIndex(state.tabScreen),
            selectedItemColor: Theme.of(context).primaryColor,
            items: navBarItems(),
            onTap: (index) {
              final tabName = tabScreenUseCase.getTabName(index);
              context
                  .read<MainScreenBloc>()
                  .add(TabScreenEvent(tabName: tabName));
            },
          );
        },
      ),
    );
  }

  Widget _onTabScreen(String tabName) {
    switch (tabName) {
      case RouteConstant.home:
        return const MainScreenAccountTab();
      case RouteConstant.transaction:
        return const MainScreenTransactionTab();
      case RouteConstant.plan:
        return const PlanTab();
      default:
        return const Text("Error");
    }
  }
}
