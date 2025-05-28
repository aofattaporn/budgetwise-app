import 'package:budget_wise/src/domain/models/transaction_dto.dart';
import 'package:budget_wise/src/data/repositories/transaction_repository_imp.dart';

class TransactionUsecase {
  final TransactionRepository transactionRepository;
  TransactionUsecase({required this.transactionRepository});

  Future<List<TransactionDto>> getAllTransactions() async {
    return await transactionRepository.getAllTransactions();
  }

  Future<List<TransactionDto>> getTransactionsByDateRange(
      DateTime start, DateTime end) async {
    // You need to implement this in your repository and datasource for real filtering.
    // For now, filter in memory as a fallback.
    final all = await transactionRepository.getAllTransactions();
    return all
        .where((t) =>
            t.transactionDate
                .isAfter(start.subtract(const Duration(microseconds: 1))) &&
            t.transactionDate.isBefore(end))
        .toList();
  }

  Future<TransactionDto?> getTransactionById(String id) async {
    return await transactionRepository.getTransactionById(id);
  }

  Future<void> createTransaction(TransactionDto dto) async {
    await transactionRepository.createTransaction(dto);
  }

  Future<void> updateTransaction(TransactionDto dto) async {
    await transactionRepository.updateTransaction(dto);
  }

  Future<void> deleteTransaction(String id) async {
    await transactionRepository.deleteTransaction(id);
  }
}
