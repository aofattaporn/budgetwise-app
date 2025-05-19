import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/common/unknown_screen.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/presentation/screens/main/main_screen.dart';
import 'package:budget_wise/src/presentation/screens/plans/plan_detail_screen.dart';
import 'package:budget_wise/src/presentation/screens/plans/plan_item_overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainScreen:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      case AppRoutes.planDetail:
        final planDto = settings.arguments as PlanDto?;
        return CupertinoPageRoute(
            builder: (context) => PlanDetailScreen(planDto: planDto));
      case AppRoutes.planItemOverviewScreen:
        return CupertinoPageRoute(
            builder: (context) => const PlanItemOverviewScreen());
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
