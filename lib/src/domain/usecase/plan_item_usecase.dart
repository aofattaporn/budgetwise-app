import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/src/domain/models/plan_item_insert_dto.dart';
import 'package:logger/logger.dart';

class PlanItemUsecase {
  static final Logger _logger = LoggerUtil.normalLogger("PlanItemUsecase");

  final PlanItemRepository planItemRepository;
  PlanItemUsecase({required this.planItemRepository});

  Future<List<PlanItemDto>> getItemsByPlanId(String planId) async {
    final result = await planItemRepository.getItemsByPlanId(planId);
    result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _logger.d("Fetched ${result.length} plan items: $result");
    return result;
  }

  Future<void> createPlanItem(PlanItemInsertDto planItemDto) async {
    _logger.d("Create plan_item name: ${planItemDto.name}");
    await planItemRepository.createPlanItem(planItemDto);
  }

  Future<void> updatePlanItem(PlanItemDto planItemDto) async {
    _logger.d("Update plan_item name: ${planItemDto.name}");
    await planItemRepository.updatePlanItem(planItemDto);
  }

  Future<void> deletePlanItem(String planItemId) async {
    _logger.d("Delete plan_item id: $planItemId");
    await planItemRepository.deletePlanItem(planItemId);
  }
}
