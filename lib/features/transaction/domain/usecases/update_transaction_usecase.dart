import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import '../../../../data/models/transaction_dto.dart';

class UpdateTransactionUsecase {
  final TransactionRepository transactionRepository;
  UpdateTransactionUsecase({required this.transactionRepository});

  Future<void> call(TransactionDto dto) async {
    await transactionRepository.updateTransaction(dto);
  }
}
