import 'package:budget_wise/src/data/models/transaction.dart';

sealed class TransactionsState {}

// Initial state when nothing has happened yet
final class InitialState extends TransactionsState {}

// state : get salary
final class GetTransactionsSuccess extends TransactionsState {
  final List<Transaction> transactions;
  GetTransactionsSuccess(this.transactions);
}

final class GetTransactionsLoading extends TransactionsState {}

final class GetTransactionsFailed extends TransactionsState {
  final String error;
  GetTransactionsFailed(this.error);
}
