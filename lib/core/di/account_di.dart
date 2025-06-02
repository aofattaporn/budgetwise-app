import 'package:budget_wise/core/di/di.dart';
import 'package:budget_wise/features/account/data/datasources/account_datasource.dart';
import 'package:budget_wise/features/account/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/features/account/domain/usecases/account_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupAccountDI() {
  // Register data layer
  sl.registerLazySingleton<AccountDataSource>(
      () => AccountRemoteDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<AccountRepository>(
      () => AccountRepositoryImp(dataSource: sl<AccountDataSource>()));

  // Register Use Cases
  sl.registerFactory<AccountUsecase>(
      () => AccountUsecase(accountRepository: sl<AccountRepository>()));

  // Register Bloc and inject the use case
  sl.registerFactory<AccountBloc>(() => AccountBloc(sl<AccountUsecase>()));
}
