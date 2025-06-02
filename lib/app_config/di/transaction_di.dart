import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/features/account/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/features/account/data/repositories/plan_item_repository_imp.dart';

import 'package:budget_wise/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/features/transaction/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_all_transactions_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_transactions_by_date_range_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_transaction_by_id_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/create_transaction_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/delete_transaction_usecase.dart';
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
  sl.registerFactory<GetAllTransactionsUsecase>(() => GetAllTransactionsUsecase(
      transactionRepository: sl<TransactionRepository>()));
  sl.registerFactory<GetTransactionsByDateRangeUsecase>(() =>
      GetTransactionsByDateRangeUsecase(
          transactionRepository: sl<TransactionRepository>()));
  sl.registerFactory<GetTransactionByIdUsecase>(() => GetTransactionByIdUsecase(
      transactionRepository: sl<TransactionRepository>()));
  sl.registerFactory<CreateTransactionUsecase>(() => CreateTransactionUsecase(
        transactionRepository: sl<TransactionRepository>(),
        accountRepository: sl<AccountRepository>(),
        planItemRepository: sl<PlanItemRepository>(),
      ));
  sl.registerFactory<UpdateTransactionUsecase>(() => UpdateTransactionUsecase(
      transactionRepository: sl<TransactionRepository>()));
  sl.registerFactory<DeleteTransactionUsecase>(() => DeleteTransactionUsecase(
      transactionRepository: sl<TransactionRepository>()));

  // Register Bloc and inject the use cases
  sl.registerFactory<TransactionBloc>(() => TransactionBloc(
        getAllTransactionsUsecase: sl<GetAllTransactionsUsecase>(),
        getTransactionsByDateRangeUsecase:
            sl<GetTransactionsByDateRangeUsecase>(),
        getTransactionByIdUsecase: sl<GetTransactionByIdUsecase>(),
        createTransactionUsecase: sl<CreateTransactionUsecase>(),
        updateTransactionUsecase: sl<UpdateTransactionUsecase>(),
        deleteTransactionUsecase: sl<DeleteTransactionUsecase>(),
      ));
}
