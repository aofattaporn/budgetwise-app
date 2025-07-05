import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/datasources/account_datasource.dart';
import 'package:budget_wise/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/domain/usecases/account_usecase.dart';
import 'package:budget_wise/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupAccountDI() {
  // Register data layer
  getIt.registerLazySingleton<AccountDataSource>(
      () => AccountRemoteDataSourceImpl(getIt<SupabaseClient>()));

  // Register Repository
  getIt.registerFactory<AccountRepository>(
      () => AccountRepositoryImp(dataSource: getIt<AccountDataSource>()));

  // Register Use Cases
  getIt.registerFactory<AccountUsecase>(
      () => AccountUsecase(accountRepository: getIt<AccountRepository>()));

  // Register Bloc and inject the use case
  getIt
      .registerFactory<AccountBloc>(() => AccountBloc(getIt<AccountUsecase>()));
}
