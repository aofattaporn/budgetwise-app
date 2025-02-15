import 'package:budget_wise/src/configs/routes/routes_name.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
import 'package:budget_wise/src/presentation/screens/unknow_screen/unknow_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.transactionScreen:
        return MaterialPageRoute(
            builder: (context) => const TransactionsScreen());
      case RoutesName.planSreen:
        return MaterialPageRoute(builder: (context) => const PlanScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const UnknowScreen(),
        );
    }
  }
}
