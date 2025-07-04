import 'package:budget_wise/shared/utils/response_util.dart';
import 'package:budget_wise/data/datasources/plan_item_datasource.dart';
import 'package:budget_wise/features/plan/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/data/models/plan_item_dto.dart';
import 'package:budget_wise/data/models/plan_item_insert_dto.dart';

abstract class PlanItemRepository {
  Future<List<PlanItemDto>> getItemsByPlanId(String planId);
  Future<void> createPlanItem(PlanItemInsertDto dto);
  Future<void> updatePlanItem(PlanItemDto dto);
  Future<void> deletePlanItem(String itemId);
  Future<List<PlanItemDto>> getAllActivePlanItems();
  Future<PlanItemDto> getItemById(String id);
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
  Future<void> createPlanItem(PlanItemInsertDto dto) async {
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

  @override
  Future<List<PlanItemDto>> getAllActivePlanItems() async {
    final response = await dataSource.fetchAllActivePlanItems();
    final List<PlanItemEntity> rawList = ResponseUtil.handleResponse(response);
    return rawList.map(PlanItemDto.fromEntity).toList();
  }

  @override
  Future<PlanItemDto> getItemById(String id) async {
    final response = await dataSource.fetchItemById(id);
    final PlanItemEntity entity = ResponseUtil.handleResponse(response);
    return PlanItemDto.fromEntity(entity);
  }
}
