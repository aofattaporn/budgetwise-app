import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

class PlanItemUsecase {
  final PlanItemRepository planItemRepository;

  PlanItemUsecase({required this.planItemRepository});

  Future<List<PlanItemEntity>?> getPlanByCurrentMonth(int planId) async {
    return await planItemRepository.fetchPlanById(planId);
  }
}
