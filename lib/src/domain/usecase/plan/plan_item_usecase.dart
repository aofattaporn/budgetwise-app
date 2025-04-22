import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:logger/logger.dart';

class PlanItemUsecase {
  final PlanItemRepository planItemRepository;

  PlanItemUsecase({required this.planItemRepository});
  final Logger _logger = LoggerUtil.usecaseLogger("PlanUsecase");

  Future<List<PlanItemEntity>?> getPlanByCurrentMonth(int planId) async {
    final result = await planItemRepository.fetchPlanById(planId);
    _logger.i("getPlanByCurrentMonth() - result: $result");
    return result;
  }
}
