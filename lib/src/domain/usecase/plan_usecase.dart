import 'package:budget_wise/src/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';

class PlanUsecase {
  final PlanRepository planRepository;
  PlanUsecase({required this.planRepository});

  Future<PlanEntity?> getPlanByCurrentMonth() async {
    var currentTime = DateTime.now();
    final result =
        await planRepository.getPlanByIntervalTime(currentTime, currentTime);
    return result;
  }

  Future<PlanEntity?> getPlanByMonthId(String id) async {
    final result = await planRepository.getPlanByMonthId(id);
    return result;
  }
}
