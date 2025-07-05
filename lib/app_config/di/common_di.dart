import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/app_config/supabase/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void commonDI() {
  // Register the database client
  getIt.registerLazySingleton<SupabaseClient>(() => dbClient);
}
