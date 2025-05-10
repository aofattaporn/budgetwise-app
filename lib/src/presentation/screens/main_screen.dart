import 'package:budget_wise/src/core/constant/route_constant.dart';
import 'package:budget_wise/src/domain/usecase/tab_screen_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_event.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_state.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/account_tab.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/home_tab.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/plan_tab.dart';
import 'package:budget_wise/src/presentation/screens/sub_screens/transaction_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabScreenUseCase = TabScreenUseCase();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return _onTabScreen(state.tabScreen);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to Create Transaction screen
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            color: Theme.of(context).bottomAppBarTheme.color ??
                Theme.of(context).colorScheme.surface,
            elevation: 16,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    icon: Icons.home_work_outlined,
                    label: "Home",
                    index: 0,
                    state: state,
                    useCase: tabScreenUseCase,
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.line_axis,
                    label: "Transactions",
                    index: 1,
                    state: state,
                    useCase: tabScreenUseCase,
                  ),
                  const SizedBox(width: 36),
                  _buildNavItem(
                    context,
                    icon: Icons.cloud,
                    label: "Plan",
                    index: 2,
                    state: state,
                    useCase: tabScreenUseCase,
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.wallet,
                    label: "Account",
                    index: 3,
                    state: state,
                    useCase: tabScreenUseCase,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required MainScreenState state,
    required TabScreenUseCase useCase,
  }) {
    final currentIndex = useCase.getTabIndex(state.tabScreen);
    final isSelected = currentIndex == index;
    final Color selectedColor = Theme.of(context).colorScheme.primary;
    final Color unselectedColor = Theme.of(context).unselectedWidgetColor;

    return GestureDetector(
      onTap: () {
        final tabName = useCase.getTabName(index);
        context.read<MainScreenBloc>().add(TabScreenEvent(tabName: tabName));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? selectedColor : unselectedColor),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onTabScreen(String tabName) {
    switch (tabName) {
      case RouteConstant.home:
        return const HomeTab();
      case RouteConstant.transaction:
        return const TypographyShowcaseScreen();
      case RouteConstant.plan:
        return const PlanTab();
      case RouteConstant.account:
        return const AccountTab();
      default:
        return const Center(child: Text("Error: Unknown tab"));
    }
  }
}
