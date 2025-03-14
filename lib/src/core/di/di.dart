import 'package:budget_wise/src/core/di/main_screen_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Load DI from each feature
  setupMainScreenDI();
}
