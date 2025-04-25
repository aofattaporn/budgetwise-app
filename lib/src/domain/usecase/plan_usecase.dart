import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:logger/logger.dart';

class PlanUsecase {
  final PlanRepository planRepository;
  PlanUsecase({required this.planRepository});
  final Logger _logger = LoggerUtil.usecaseLogger("PlanUsecase");

  Future<PlanEntity?> getPlanByCurrentMonth() async {
    var currentTime = DateTime.now();
    final result =
        await planRepository.getPlanByIntervalTime(currentTime, currentTime);
    _logger.i(
        "getPlanByCurrentMonth() -time: ${UtilsDateTime.yearMonthFormat(currentTime)} - success");
    return result;
  }

  Future<PlanEntity?> getPlanByMonthId(int id) async {
    final result = await planRepository.getPlanByMonthId(id);
    _logger.i("getPlanByMonthId() - id: $id - result: $result");
    return result;
  }

  Future<List<PlanEntity>> getAllPlans() async {
    final result = await planRepository.getAllPlans();
    _logger.i("getAllPlans() - result count: ${result.length}");
    return result;
  }

  Future<void> createPlan(PlanDto planDto) async {
    await planRepository.createPlan(PlanDto(
      startDate: planDto.startDate,
      endDate: planDto.endDate,
      totalBudget: planDto.totalBudget,
    ));
    _logger.i("createPlan() - planDto: $planDto - success");
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
    _logger.i("eidtPlan() - id: $id - success");
  }

  Future<void> deletePlan(int id) async {
    await planRepository.deletePlan(id);
    _logger.i("deletePlan() id: $id - success");
  }
}
