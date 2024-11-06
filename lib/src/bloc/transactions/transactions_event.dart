import 'package:budget_wise/src/models/entity/transaction_entity.dart';

sealed class TransactionsEvent {}

// event: create account
final class GetTransactionsEvent extends TransactionsEvent {
  GetTransactionsEvent();
}

final class CreateTransactionsEvent extends TransactionsEvent {
  TransactionEntity transaction;
  CreateTransactionsEvent(this.transaction);
}
