import 'package:budget_wise/src/bloc/navigate_screen_bloc/navigate_screen_event.dart';
import 'package:budget_wise/src/bloc/navigate_screen_bloc/navigate_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigateScreenBloc
    extends Bloc<NavigateScreenEvent, NavigateScreenState> {
  NavigateScreenBloc() : super(InitialState()) {
    on<PushNamedNavigateEvent>(_pushNamedNavigateEvent);
  }

  void _pushNamedNavigateEvent(
    PushNamedNavigateEvent event,
    Emitter<NavigateScreenState> emit,
  ) {
    Navigator.pushNamed(event.context, event.settings.name!);
  }
}
