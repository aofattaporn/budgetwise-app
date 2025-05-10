// import 'package:budget_wise/src/core/utils/response_util.dart';
// import 'package:budget_wise/src/data/datasources/plan_item_datasource.dart';
// import 'package:budget_wise/src/domain/entities/plan_item_temp_entity.dart';
// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';

// abstract class PlanItemRepository {
//   Future<List<PlanItemEntity>> fetchPlanById(int planId);
//   Future<List<PlanItemEntity>> createNewPlanItem(PlanItemDto planItemDto);
//   Future<List<PlanItemEntity>> deletePlanItemById(
//       String planItemId, int planId);
//   Future<List<PlanItemEntity>> updatePlanItemById(
//       String planItemId, PlanItemDto planDto);
// }

// class PlanRepositoryItemImp implements PlanItemRepository {
//   final PlanItemDataSource planItemDataSource;

//   PlanRepositoryItemImp({required this.planItemDataSource});

//   @override
//   Future<List<PlanItemEntity>> fetchPlanById(int planId) async {
//     final response = await planItemDataSource.fetchPlanById(planId);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<List<PlanItemEntity>> createNewPlanItem(
//       PlanItemDto planItemDto) async {
//     final response = await planItemDataSource.createNewPlanItem(planItemDto);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<List<PlanItemEntity>> deletePlanItemById(
//       String planItemId, int planId) async {
//     final response =
//         await planItemDataSource.deletePlanItemById(planItemId, planId);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<List<PlanItemEntity>> updatePlanItemById(
//       String planItemId, PlanItemDto planDto) async {
//     final response =
//         await planItemDataSource.updatePlanItemById(planItemId, planDto);
//     return ResponseUtil.handleResponse(response);
//   }
// }
