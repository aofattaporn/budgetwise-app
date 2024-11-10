import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/home';
  static const String transaction = '/transaction';
  static const String plan = '/plan';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case transaction:
        return CupertinoPageRoute(builder: (_) => const TransactionsScreen());
      case plan:
        return CupertinoPageRoute(builder: (_) => const PlanScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
