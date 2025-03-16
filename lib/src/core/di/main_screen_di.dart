import 'package:budget_wise/src/domain/usecase/home/tab_screen_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupMainScreenDI() {
  // Register Use Cases
  sl.registerLazySingleton<TabScreenUseCase>(() => TabScreenUseCase());

  // Register Bloc and inject the use case
  sl.registerFactory(() => MainScreenBloc(sl<TabScreenUseCase>()));
}
