import 'package:budget_wise/src/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/domain/repositories/plan_item_repository.dart';

class PlanRepositoryItemImp implements PlanItemRepository {
  final PlanItemDataSource planItemDataSource;

  PlanRepositoryItemImp({required this.planItemDataSource});

  @override
  Future<List<PlanItemEntity>?> fetchPlanById(int planId) {
    return planItemDataSource.fetchPlanById(planId);
  }
}
