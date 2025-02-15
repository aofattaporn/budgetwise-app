import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_event.dart';
import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_state.dart';
import 'package:budget_wise/src/constant/route_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  static const String initialTab = RouteConstant.home;
  MainScreenBloc() : super(InitialState(tabScreen: initialTab)) {
    on<TabScreenEvent>(_tabScreenEvent);
  }

  void _tabScreenEvent(
    TabScreenEvent event,
    Emitter<MainScreenState> emit,
  ) {
    emit(TabSuccessState(tabScreen: event.tabName));
  }
}
