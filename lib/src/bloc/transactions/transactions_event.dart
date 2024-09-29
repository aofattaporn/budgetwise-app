import 'package:budget_wise/src/data/models/transaction.dart';

sealed class TransactionsEvent {}

// event: create account
final class GetTransactionsEvent extends TransactionsEvent {
  GetTransactionsEvent();
}

final class CreateTransactionsEvent extends TransactionsEvent {
  Transaction transaction;
  CreateTransactionsEvent(this.transaction);
}
