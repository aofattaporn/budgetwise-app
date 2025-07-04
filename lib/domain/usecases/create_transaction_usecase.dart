import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/data/repositories/account_repository_imp.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/data/models/transaction_dto.dart';
import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';
import 'package:budget_wise/shared/utils/error_util.dart';
import 'package:budget_wise/shared/utils/logger_util.dart';
import 'package:logger/logger.dart';

class CreateTransactionUsecase {
  static final Logger _logger =
      LoggerUtil.normalLogger("CreateTransactionUsecase");

  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  final PlanItemRepository planItemRepository;

  CreateTransactionUsecase({
    required this.transactionRepository,
    required this.accountRepository,
    required this.planItemRepository,
  });

  Future<void> call(TransactionDto dto) async {
    try {
      // validate bussiness logic
      if (dto.amount <= 0) {
        throw ErrorUtil.mapBusinessError(
          desc: 'Amount must be greater than 0',
        );
      }

      if (dto.name.isEmpty) {
        throw ErrorUtil.mapBusinessError(
          desc: 'Name is required',
        );
      }
      _logger.d("Validate amount: ${dto.amount}");

      // validate plan item balance
      final planItem = await planItemRepository.getItemById(dto.planItemId!);
      _logger.d("Validate plan item balance: ${planItem.amountLimit}");
      if (dto.amount > planItem.amountLimit) {
        throw ErrorUtil.mapBusinessError(
          desc: "Plan item balance is not enough",
        );
      }

      _logger.d("Create transaction: ${dto.toJson()}");
      return await transactionRepository.createTransaction(dto);
    } on BussinessError catch (e) {
      _logger.e(e.desc);
      rethrow;
    } on Exception catch (e) {
      _logger.e(e.toString());
      throw ErrorUtil.mapTechnicalError(message: e.toString());
    }
  }
}
