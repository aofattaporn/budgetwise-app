import 'package:budget_wise/features/plan/data/models/plan_dto.dart';
import 'package:budget_wise/shared/common/unknown_screen.dart';
import 'package:budget_wise/app_config/routes/app_routes.dart';
import 'package:budget_wise/features/home/presentation/main_screen.dart';
import 'package:budget_wise/features/plan/presentation/plan_detail_screen.dart';
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
      default:
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
    }
  }
}
