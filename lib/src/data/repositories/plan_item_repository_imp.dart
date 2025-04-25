import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';

abstract class PlanItemRepository {
  Future<List<PlanItemEntity>?> fetchPlanById(int planId);
}

class PlanRepositoryItemImp implements PlanItemRepository {
  final PlanItemDataSource planItemDataSource;

  PlanRepositoryItemImp({required this.planItemDataSource});

  @override
  Future<List<PlanItemEntity>?> fetchPlanById(int planId) async {
    final response = await planItemDataSource.fetchPlanById(planId);
    return ResponseUtil.handleResponse(response);
  }
}
