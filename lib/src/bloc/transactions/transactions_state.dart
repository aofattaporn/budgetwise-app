import 'package:budget_wise/src/models/entity/transaction_entity.dart';

sealed class TransactionsState {}

// Initial state when nothing has happened yet
final class InitialState extends TransactionsState {}

// state : get salary
final class GetTransactionsSuccess extends TransactionsState {
  final List<TransactionEntity> transactions;
  GetTransactionsSuccess(this.transactions);
}

final class GetTransactionsLoading extends TransactionsState {}

final class GetTransactionsFailed extends TransactionsState {
  final String error;
  GetTransactionsFailed(this.error);
}
