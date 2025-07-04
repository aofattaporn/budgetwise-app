import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import '../../data/models/transaction_dto.dart';

class GetTransactionByIdUsecase {
  final TransactionRepository transactionRepository;
  GetTransactionByIdUsecase({required this.transactionRepository});

  Future<TransactionDto?> call(String id) async {
    return await transactionRepository.getTransactionById(id);
  }
}
