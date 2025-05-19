import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';

class PlanUsecase {
  final PlanRepository planRepository;
  PlanUsecase({required this.planRepository});

  Future<PlanDto?> getPlanByCurrentMonth() async {
    var currentTime = DateTime.now();
    final result =
        await planRepository.getPlanByIntervalTime(currentTime, currentTime);
    return result;
  }

  Future<PlanDto?> getPlanByMonthId(String id) async {
    final result = await planRepository.getPlanByMonthId(id);
    return result;
  }

  Future<List<PlanDto>> getAllPlans() async {
    final result = await planRepository.getAllPlans();
    return result;
  }

  Future<void> createPlan(PlanDto planDto) async {
    await planRepository.createPlan(planDto);
  }
}
