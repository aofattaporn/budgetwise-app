import 'package:budget_wise/src/domain/models/transaction_dto.dart';
import 'package:budget_wise/src/data/repositories/transaction_repository_imp.dart';

class TransactionUsecase {
  final TransactionRepository transactionRepository;
  TransactionUsecase({required this.transactionRepository});

  Future<List<TransactionDto>> getAllTransactions() async {
    return await transactionRepository.getAllTransactions();
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
