import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/src/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/src/domain/usecase/transaction_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_bloc.dart';
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

  // Register Bloc and inject the use case
  sl.registerFactory<TransactionBloc>(
      () => TransactionBloc(sl<TransactionUsecase>()));
}
