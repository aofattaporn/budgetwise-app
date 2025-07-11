import 'package:budget_wise/app_config/di/bloc_di/bloc_di.dart';
import 'package:budget_wise/app_config/di/datasource_di/datasource_di.dart';
import 'package:budget_wise/app_config/di/repository_di/repositories_di.dart';
import 'package:budget_wise/app_config/di/usecase_di/usecase_di.dart';
import 'package:budget_wise/app_config/supabase/supabase_config.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // comon di
  getIt.registerLazySingleton<SupabaseClient>(() => dbClient);
  datasorceDI();
  repositoriesDI();
  usecaseDI();
  blocDI();
}
