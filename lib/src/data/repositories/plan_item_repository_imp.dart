import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';

abstract class PlanItemRepository {
  Future<List<PlanItemDto>> getItemsByPlanId(String planId);
  Future<void> createPlanItem(PlanItemDto dto);
  Future<void> updatePlanItem(PlanItemDto dto);
  Future<void> deletePlanItem(String itemId);
}

class PlanItemRepositoryImp implements PlanItemRepository {
  final PlanItemDataSource dataSource;

  PlanItemRepositoryImp({required this.dataSource});

  @override
  Future<List<PlanItemDto>> getItemsByPlanId(String planId) async {
    final response = await dataSource.fetchItemsByPlanId(planId);
    final List<PlanItemEntity> rawList = ResponseUtil.handleResponse(response);
    return rawList.map(PlanItemDto.fromEntity).toList();
  }

  @override
  Future<void> createPlanItem(PlanItemDto dto) async {
    final response = await dataSource.createPlanItem(dto);
    ResponseUtil.handleResponse(response); // handle errors, returns void
  }

  @override
  Future<void> updatePlanItem(PlanItemDto dto) async {
    final response = await dataSource.updatePlanItem(dto);
    ResponseUtil.handleResponse(response); // handle errors, returns void
  }

  @override
  Future<void> deletePlanItem(String itemId) async {
    final response = await dataSource.deletePlanItem(itemId);
    ResponseUtil.handleResponse(response); // handle errors, returns void
  }
}
