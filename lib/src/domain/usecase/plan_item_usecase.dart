import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:logger/logger.dart';

class PlanItemUsecase {
  static final Logger _logger = LoggerUtil.normalLogger("PlanItemUsecase");

  final PlanItemRepository planItemRepository;
  PlanItemUsecase({required this.planItemRepository});

  Future<List<PlanItemDto>> getItemsByPlanId(String planId) async {
    final result = await planItemRepository.getItemsByPlanId(planId);
    _logger.d("Fetched ${result.length} plan items: $result");
    return result;
  }
}
