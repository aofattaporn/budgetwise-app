import 'package:budget_wise/features/transaction/data/models/transaction_dto.dart';

abstract class TransactionEvent {}

class FetchAllTransactions extends TransactionEvent {}

class FetchTransactionsByDateRange extends TransactionEvent {
  final DateTime start;
  final DateTime end;
  FetchTransactionsByDateRange(this.start, this.end);
}

class CreateTransaction extends TransactionEvent {
  final TransactionDto dto;
  CreateTransaction(this.dto);
}

class UpdateTransaction extends TransactionEvent {
  final TransactionDto dto;
  UpdateTransaction(this.dto);
}

class DeleteTransaction extends TransactionEvent {
  final String id;
  DeleteTransaction(this.id);
}
