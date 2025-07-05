import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';

import 'package:budget_wise/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/domain/usecases/get_all_transactions_usecase.dart';
import 'package:budget_wise/domain/usecases/get_transactions_by_date_range_usecase.dart';
import 'package:budget_wise/domain/usecases/get_transaction_by_id_usecase.dart';
import 'package:budget_wise/domain/usecases/create_transaction_usecase.dart';
import 'package:budget_wise/domain/usecases/update_transaction_usecase.dart';
import 'package:budget_wise/domain/usecases/delete_transaction_usecase.dart';
import 'package:budget_wise/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupTransactionDI() {
  // Register data layer
  getIt.registerLazySingleton<TransactionDataSource>(
      () => TransactionRemoteDataSourceImpl(getIt<SupabaseClient>()));

  // Register Repository
  getIt.registerFactory<TransactionRepository>(() =>
      TransactionRepositoryImp(dataSource: getIt<TransactionDataSource>()));

  // Register Use Cases
  getIt.registerFactory<GetAllTransactionsUsecase>(() =>
      GetAllTransactionsUsecase(
          transactionRepository: getIt<TransactionRepository>()));
  getIt.registerFactory<GetTransactionsByDateRangeUsecase>(() =>
      GetTransactionsByDateRangeUsecase(
          transactionRepository: getIt<TransactionRepository>()));
  getIt.registerFactory<GetTransactionByIdUsecase>(() =>
      GetTransactionByIdUsecase(
          transactionRepository: getIt<TransactionRepository>()));
  getIt
      .registerFactory<CreateTransactionUsecase>(() => CreateTransactionUsecase(
            transactionRepository: getIt<TransactionRepository>(),
            accountRepository: getIt<AccountRepository>(),
            planItemRepository: getIt<PlanItemRepository>(),
          ));
  getIt.registerFactory<UpdateTransactionUsecase>(() =>
      UpdateTransactionUsecase(
          transactionRepository: getIt<TransactionRepository>()));
  getIt.registerFactory<DeleteTransactionUsecase>(() =>
      DeleteTransactionUsecase(
          transactionRepository: getIt<TransactionRepository>()));

  // Register Bloc and inject the use cases
  getIt.registerFactory<TransactionBloc>(() => TransactionBloc(
        getAllTransactionsUsecase: getIt<GetAllTransactionsUsecase>(),
        getTransactionsByDateRangeUsecase:
            getIt<GetTransactionsByDateRangeUsecase>(),
        getTransactionByIdUsecase: getIt<GetTransactionByIdUsecase>(),
        createTransactionUsecase: getIt<CreateTransactionUsecase>(),
        updateTransactionUsecase: getIt<UpdateTransactionUsecase>(),
        deleteTransactionUsecase: getIt<DeleteTransactionUsecase>(),
      ));
}
