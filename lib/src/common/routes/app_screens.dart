import 'package:budget_wise/src/common/presentation/unknown_screen.dart';
import 'package:budget_wise/src/common/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainScreen:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
    }
  }
}
