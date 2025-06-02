import 'package:budget_wise/features/transaction/domain/usecases/tab_screen_usecase.dart';
import 'package:budget_wise/features/home/presentation/bloc/main_screen_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupMainScreenDI() {
  // Register Use Cases
  sl.registerLazySingleton<TabScreenUseCase>(() => TabScreenUseCase());

  // Register Bloc and inject the use case
  sl.registerFactory(() => MainScreenBloc(sl<TabScreenUseCase>()));
}
