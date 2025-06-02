import 'package:budget_wise/core/di/di.dart';
import 'package:budget_wise/core/supabase/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void commonDI() {
  // Register the database client
  sl.registerLazySingleton<SupabaseClient>(() => dbClient);
}
