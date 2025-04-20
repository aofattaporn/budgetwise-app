import 'package:budget_wise/src/common/presentation/unknown_screen.dart';
import 'package:budget_wise/src/common/routes/app_routes.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/presentation/screens/main_screen.dart';
import 'package:budget_wise/src/presentation/screens/new_planning_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainScreen:
        return CupertinoPageRoute(builder: (context) => const MainScreen());
      case AppRoutes.newPlanningScreen:
        final args = settings.arguments;
        PlanDto? planDto;
        int? id;

        if (args != null && args is Map<String, dynamic>) {
          planDto = args['planDto'] as PlanDto?;
          id = args['id'] as int?;
        }

        return CupertinoPageRoute(
          builder: (context) => NewPlanningScreen(planDto: planDto, id: id),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
    }
  }
}
