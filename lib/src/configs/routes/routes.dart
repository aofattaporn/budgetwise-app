import 'package:budget_wise/src/configs/routes/routes_name.dart';
import 'package:budget_wise/src/screens/main_screen/main_screen.dart';
import 'package:budget_wise/src/screens/unknow_screen/unknow_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.mainScreen:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
    }
  }
}
