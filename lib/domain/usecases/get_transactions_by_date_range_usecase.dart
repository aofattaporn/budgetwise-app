import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import '../../data/models/transaction_dto.dart';

class GetTransactionsByDateRangeUsecase {
  final TransactionRepository transactionRepository;
  GetTransactionsByDateRangeUsecase({required this.transactionRepository});

  Future<List<TransactionDto>> call(DateTime start, DateTime end) async {
    final all = await transactionRepository.getAllTransactions();
    return all
        .where((t) =>
            t.transactionDate
                .isAfter(start.subtract(const Duration(microseconds: 1))) &&
            t.transactionDate.isBefore(end))
        .toList();
  }
}
