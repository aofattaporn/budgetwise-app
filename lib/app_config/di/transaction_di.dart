import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/features/account/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/features/account/data/repositories/plan_item_repository_imp.dart';

import 'package:budget_wise/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/features/transaction/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/features/transaction/domain/usecases/create_transaction_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/transaction_usecase.dart';
import 'package:budget_wise/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupTransactionDI() {
  // Register data layer
  sl.registerLazySingleton<TransactionDataSource>(
      () => TransactionRemoteDataSourceImpl(sl<SupabaseClient>()));

  // Register Repository
  sl.registerFactory<TransactionRepository>(
      () => TransactionRepositoryImp(dataSource: sl<TransactionDataSource>()));

  // Register Use Cases
  sl.registerFactory<TransactionUsecase>(() =>
      TransactionUsecase(transactionRepository: sl<TransactionRepository>()));
  sl.registerFactory<CreateTransactionUsecase>(() => CreateTransactionUsecase(
        transactionRepository: sl<TransactionRepository>(),
        accountRepository: sl<AccountRepository>(),
        planItemRepository: sl<PlanItemRepository>(),
      ));

  // Register Bloc and inject the use case
  sl.registerFactory<TransactionBloc>(() => TransactionBloc(
        transactionUsecase: sl<TransactionUsecase>(),
        createTransactionUsecase: sl<CreateTransactionUsecase>(),
      ));
}
