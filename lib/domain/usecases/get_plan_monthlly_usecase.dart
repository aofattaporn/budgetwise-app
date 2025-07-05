import 'package:budget_wise/core/common/common_usecase.dart';
import 'package:budget_wise/data/models/plan_monthly_budget.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';

class GetPlanMonthllyUsecase extends CommonUseCase<void, String> {
  final PlanRepository _planRepository;

  GetPlanMonthllyUsecase({required PlanRepository planRepository})
      : _planRepository = planRepository;
  @override
  Future<PlanMonthlyBudget> call(String? params) async {
    _planRepository.getPlanByMonthId("");
    return PlanMonthlyBudget.mock();
  }
}
