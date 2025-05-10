// import 'package:budget_wise/src/domain/models/common/common_response.dart';
// import 'package:budget_wise/src/core/constant/response_constant.dart';
// import 'package:budget_wise/src/core/errors/bussiness_error.dart';
// import 'package:budget_wise/src/core/utils/error_util.dart';
// import 'package:budget_wise/src/core/utils/logger_util.dart';
// import 'package:budget_wise/src/core/utils/response_util.dart';
// import 'package:budget_wise/src/domain/entities/plan_item_temp_entity.dart';
// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
// import 'package:logger/logger.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// abstract class PlanItemDataSource {
//   Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId);
//   Future<CommonResponse<List<PlanItemEntity>>> createNewPlanItem(
//       PlanItemDto planItemDto);
//   Future<CommonResponse<List<PlanItemEntity>>> deletePlanItemById(
//       String planItemId, int planId);
//   Future<CommonResponse<List<PlanItemEntity>>> updatePlanItemById(
//       String planItemId, PlanItemDto planItemDto);
// }

// class PlanItemDataSourceImpl implements PlanItemDataSource {
//   final SupabaseClient supabase;
//   final Logger _logger = LoggerUtil.datasourceLogger("PlanItemDataSourceImpl");

//   PlanItemDataSourceImpl(this.supabase);

//   @override
//   Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId) async {
//     try {
//       final response =
//           await supabase.from('plan_items').select().eq('plan_id', planId);

//       final planItemList = response
//           .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
//           .toList();

//       return ResponseUtil.commonResponse(
//           ResponseConstant.code1000, planItemList);
//     } on BussinessError {
//       rethrow;
//     } catch (e, stackTrace) {
//       _logger.e('Technical Error | fetchPlanById: $planId',
//           error: e, stackTrace: stackTrace);
//       throw ErrorUtil.mapTechnicalError();
//     }
//   }

//   @override
//   Future<CommonResponse<List<PlanItemEntity>>> createNewPlanItem(
//       PlanItemDto planItemDto) async {
//     try {
//       // Fetch existing items and total used
//       final existingItems = await supabase
//           .from('plan_items')
//           .select('plan_amount')
//           .eq('plan_id', planItemDto.planId);

//       final currentTotal = existingItems.fold<double>(
//         0,
//         (sum, item) => sum + (item['plan_amount'] as num).toDouble(),
//       );

//       // Get totalBudget from plan
//       final planJson = await supabase
//           .from('plans')
//           .select('total_budget')
//           .eq('id', planItemDto.planId)
//           .maybeSingle();

//       final totalBudget = (planJson?['total_budget'] as num?)?.toDouble() ?? 0;

//       // Business validation
//       final newTotal = currentTotal + planItemDto.planAmount;
//       if (newTotal > totalBudget) {
//         _logger.w("💥 Over budget: $newTotal / $totalBudget");
//         throw ErrorUtil.mapBusinessError(
//           message: "Budget exceeded. Try lowering the amount.",
//         );
//       }

//       // Insert new item
//       await supabase
//           .from('plan_items')
//           .insert(PlanItemEntity.toJsonInsert(planItemDto));

//       // Return updated list
//       final updatedItems = await supabase
//           .from('plan_items')
//           .select()
//           .eq('plan_id', planItemDto.planId);

//       final result = updatedItems
//           .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
//           .toList();

//       return ResponseUtil.commonResponse(ResponseConstant.code1000, result);
//     } on BussinessError {
//       rethrow;
//     } catch (e, stackTrace) {
//       _logger.e(
//         '❌ createNewPlanItem failed',
//         error: e,
//         stackTrace: stackTrace,
//       );
//       throw ErrorUtil.mapTechnicalError();
//     }
//   }

//   // @override
//   // Future<CommonResponse<List<PlanItemEntity>>> createNewPlanItem(
//   //     PlanItemDto planItemDto) async {
//   //   try {
//   //     await supabase
//   //         .from('plan_items')
//   //         .insert(PlanItemEntity.toJsonInsert(planItemDto))
//   //         .select();

//   //     final response = await supabase
//   //         .from('plan_items')
//   //         .select()
//   //         .eq('plan_id', planItemDto.planId);

//   //     final planItemList = response
//   //         .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
//   //         .toList();

//   //     return ResponseUtil.commonResponse(
//   //       ResponseConstant.code1000,
//   //       planItemList,
//   //     );
//   //   } on BussinessError {
//   //     rethrow;
//   //   } catch (e, stackTrace) {
//   //     _logger.e(
//   //       'Technical Error | createNewPlanItem: ',
//   //       error: e,
//   //       stackTrace: stackTrace,
//   //     );
//   //     throw ErrorUtil.mapTechnicalError();
//   //   }
//   // }

//   @override
//   Future<CommonResponse<List<PlanItemEntity>>> deletePlanItemById(
//       String planItemId, int planId) async {
//     try {
//       await supabase.from('plan_items').delete().eq('id', planItemId);

//       final response =
//           await supabase.from('plan_items').select().eq('plan_id', planId);

//       final planItemList = response
//           .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
//           .toList();

//       return ResponseUtil.commonResponse(
//         ResponseConstant.code1000,
//         planItemList,
//       );
//     } on BussinessError {
//       rethrow;
//     } catch (e, stackTrace) {
//       _logger.e(
//         'Technical Error | deletePlanIteById: id=$planItemId',
//         error: e,
//         stackTrace: stackTrace,
//       );
//       throw ErrorUtil.mapTechnicalError();
//     }
//   }

//   @override
//   Future<CommonResponse<List<PlanItemEntity>>> updatePlanItemById(
//       String planItemId, PlanItemDto planItemDto) async {
//     try {
//       print(planItemId);
//       print(PlanItemEntity.toJsonUpdate(planItemDto));

//       await supabase
//           .from('plan_items')
//           .update(PlanItemEntity.toJsonUpdate(planItemDto))
//           .eq('id', planItemId);

//       final response = await supabase
//           .from('plan_items')
//           .select()
//           .eq('plan_id', planItemDto.planId);

//       final planItemList = response
//           .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
//           .toList();

//       return ResponseUtil.commonResponse(
//           ResponseConstant.code1000, planItemList);
//     } catch (e, stackTrace) {
//       _logger.e("Technical Error | updatePlan",
//           error: e, stackTrace: stackTrace);
//       throw ErrorUtil.mapTechnicalError();
//     }
//   }
// }
