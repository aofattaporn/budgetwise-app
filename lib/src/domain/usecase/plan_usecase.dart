import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';

class PlanUsecase {
  final PlanRepository planRepository;
  PlanUsecase({required this.planRepository});

  Future<PlanEntity?> getPlanByCurrentMonth() async {
    var currentTime = DateTime.now();
    final result =
        await planRepository.getPlanByIntervalTime(currentTime, currentTime);
    return result;
  }

  Future<PlanEntity?> getPlanByMonthId(int id) async {
    final result = await planRepository.getPlanByMonthId(id);
    return result;
  }

  Future<List<PlanEntity>> getAllPlans() async {
    final result = await planRepository.getAllPlans();
    return result;
  }

  Future<void> createPlan(PlanDto planDto) async {
    await planRepository.createPlan(PlanDto(
      startDate: planDto.startDate,
      endDate: planDto.endDate,
      totalBudget: planDto.totalBudget,
    ));
  }

  Future<void> eidtPlan(PlanDto planDto, int id) async {
    await planRepository.updatePlan(
      PlanDto(
        startDate: planDto.startDate,
        endDate: planDto.endDate,
        totalBudget: planDto.totalBudget,
      ),
      id,
    );
  }

  Future<void> deletePlan(int id) async {
    await planRepository.deletePlan(id);
  }
}
