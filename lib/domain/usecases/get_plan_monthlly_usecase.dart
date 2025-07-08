import 'package:budget_wise/core/common/common_usecase.dart';
import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/data/repositories/transaction_repository_imp.dart';

class GetPlanMonthlyUsecase extends CommonUseCase<PlanMonthlyBudget, String> {
  final PlanRepository planRepository;
  final TransactionRepository transactionRepository;

  GetPlanMonthlyUsecase({
    required this.planRepository,
    required this.transactionRepository,
  });

  @override
  Future<PlanMonthlyBudget> call(String? planId) async {
    PlanDto planDto;

    // chhcking if planId is null or empty
    if (planId == null || planId.isEmpty) {
      planDto = await planRepository.getPlanByDefault();
    } else {
      planDto = await planRepository.getPlanByMonthId(planId);
    }

    // assign new plan
    final String newPlanId = planDto.id!;

    // inquiry transaction by new planId
    final transactions =
        await transactionRepository.getTransactionByPlanId(newPlanId);

    // create PlanMonthlyBudget object
    final PlanMonthlyBudget planMonthlyBudget = PlanMonthlyBudget(
      id: newPlanId,
      userId: planDto.userId,
      name: planDto.name,
      startDate: planDto.startDate,
      endDate: planDto.endDate,
      amountLimit: planDto.amountLimit,
      isArchived: planDto.isArchived,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      summaryTransactions:
          transactions?.map((e) => e.toSummaryTransaction()).toList(),
    );

    return PlanMonthlyBudget.mock();
  }
}
