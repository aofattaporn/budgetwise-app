import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/datasources/account_datasource.dart';
import 'package:budget_wise/data/datasources/plan_datasource.dart';
import 'package:budget_wise/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/data/datasources/transaction_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void datasorceDI() {
  // Register Datasource
  getIt.registerLazySingleton<PlanDataSource>(
      () => PlanRemoteDataSourceImpl(client: getIt<SupabaseClient>()));
  getIt.registerLazySingleton<PlanItemDataSource>(
      () => PlanItemRemoteDataSourceImpl(client: getIt<SupabaseClient>()));
  getIt.registerLazySingleton<TransactionDataSource>(
      () => TransactionRemoteDataSourceImpl(client: getIt<SupabaseClient>()));
  getIt.registerLazySingleton<AccountDataSource>(
      () => AccountRemoteDataSourceImpl(getIt<SupabaseClient>()));
}
