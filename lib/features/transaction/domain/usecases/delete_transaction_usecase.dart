import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';

class DeleteTransactionUsecase {
  final TransactionRepository transactionRepository;
  DeleteTransactionUsecase({required this.transactionRepository});

  Future<void> call(String id) async {
    await transactionRepository.deleteTransaction(id);
  }
}
