import 'package:budget_wise/src/presentation/common/unknown_screen.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
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

  // // (SelectIconScreen)
  // static CupertinoPageRoute<dynamic> _prepareSelectIconScreen(
  //     RouteSettings settings) {
  //   final args = settings.arguments as SelectIconScreen;
  //   return CupertinoPageRoute(
  //       builder: (context) => SelectIconScreen(
  //             initialIcon: args.initialIcon,
  //             handleSelectIcon: args.handleSelectIcon,
  //           ));
  // }
}
