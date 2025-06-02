import 'package:budget_wise/features/transaction/domain/usecases/tab_screen_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_event.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final TabScreenUseCase tabScreenUseCase;

  MainScreenBloc(this.tabScreenUseCase) : super(MainScreenState.initial()) {
    on<TabScreenEvent>((event, emit) {
      emit(state.copyWith(tabScreen: event.tabName));
    });
  }
}
