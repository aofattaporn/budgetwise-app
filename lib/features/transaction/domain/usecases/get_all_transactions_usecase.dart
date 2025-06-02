import 'package:budget_wise/features/transaction/data/repositories/transaction_repository_imp.dart';
import '../../data/models/transaction_dto.dart';

class GetAllTransactionsUsecase {
  final TransactionRepository transactionRepository;
  GetAllTransactionsUsecase({required this.transactionRepository});

  Future<List<TransactionDto>> call() async {
    return await transactionRepository.getAllTransactions();
  }
}
