import 'package:budget_wise/core/constant/route_constant.dart';

class MainScreenState {
  final String tabScreen;

  MainScreenState({required this.tabScreen});

  factory MainScreenState.initial() {
    return MainScreenState(tabScreen: RouteConstant.home);
  }

  MainScreenState copyWith({String? tabScreen}) {
    return MainScreenState(
      tabScreen: tabScreen ?? this.tabScreen,
    );
  }
}
