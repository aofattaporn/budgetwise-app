// domain/usecases/tab_screen_usecase.dart
import 'package:budget_wise/src/core/constant/route_constant.dart';

class TabScreenUseCase {
  String getTabName(int index) {
    switch (index) {
      case 0:
        return RouteConstant.home;
      case 1:
        return RouteConstant.transaction;
      case 2:
        return RouteConstant.plan;
      case 3:
        return RouteConstant.account;
      default:
        return RouteConstant.home;
    }
  }

  int getTabIndex(String tabName) {
    switch (tabName) {
      case RouteConstant.home:
        return 0;
      case RouteConstant.transaction:
        return 1;
      case RouteConstant.plan:
        return 2;
      case RouteConstant.account:
        return 3;
      default:
        return -1;
    }
  }
}
