import 'package:budget_wise/src/presentation/common/unknown_screen.dart';
import 'package:budget_wise/src/presentation/routes/app_routes.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/screens/main_screen.dart';
import 'package:budget_wise/src/presentation/screens/new_planning_screen.dart';
import 'package:budget_wise/src/presentation/screens/select_icon_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainScreen:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      case AppRoutes.newPlanningScreen:
        return _prepareNewPanScreen(settings);
      case AppRoutes.selectIconScreen:
        return _prepareSelectIconScreen(settings);
      default:
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
    }
  }

  // (NewPlanningScreenArgs)
  static CupertinoPageRoute<dynamic> _prepareNewPanScreen(
      RouteSettings settings) {
    final args = settings.arguments;
    PlanDto? planDto;
    int? id;

    if (args != null && args is Map<String, dynamic>) {
      planDto = args['planDto'] as PlanDto?;
      id = args['id'] as int?;
    }

    return CupertinoPageRoute(
      // builder: (context) => NewPlanningScreen(planDto: planDto, id: id),
      builder: (context) => const Text(""),
    );
  }

  // (SelectIconScreen)
  static CupertinoPageRoute<dynamic> _prepareSelectIconScreen(
      RouteSettings settings) {
    final args = settings.arguments as SelectIconScreen;
    return CupertinoPageRoute(
        builder: (context) => SelectIconScreen(
              initialIcon: args.initialIcon,
              handleSelectIcon: args.handleSelectIcon,
            ));
  }
}
