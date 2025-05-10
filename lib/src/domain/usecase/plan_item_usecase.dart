// import 'package:budget_wise/src/data/repositories/plan_item_repository_imp.dart';
// import 'package:budget_wise/src/domain/entities/plan_item_temp_entity.dart';
// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';

// class PlanItemUsecase {
//   final PlanItemRepository planItemRepository;

//   PlanItemUsecase({required this.planItemRepository});

//   Future<List<PlanItemEntity>> getPlanByCurrentMonth(int planId) async {
//     final result = await planItemRepository.fetchPlanById(planId);
//     return result;
//   }

//   Future<List<PlanItemEntity>> createaNewPlanIte(
//       PlanItemDto planItemDto) async {
//     final result = await planItemRepository.createNewPlanItem(planItemDto);
//     return result;
//   }

//   Future<List<PlanItemEntity>> deletePlanItemById(
//       String planItemId, int planId) async {
//     final result =
//         await planItemRepository.deletePlanItemById(planItemId, planId);
//     return result;
//   }

//   Future<List<PlanItemEntity>> updatePlanItemById(
//       String planItemId, PlanItemDto planDto) async {
//     final result =
//         await planItemRepository.updatePlanItemById(planItemId, planDto);
//     return result;
//   }
// }
