import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

abstract class PlanItemRepository {
  Future<List<PlanItemEntity>?> fetchPlanById(int planId);
}
