import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/utils/error_util.dart';
import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:budget_wise/src/domain/models/plan_item_insert_dto.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlanItemDataSource {
  Future<CommonResponse<List<PlanItemEntity>>> fetchItemsByPlanId(
      String planId);
  Future<CommonResponse<void>> createPlanItem(PlanItemInsertDto dto);
  Future<CommonResponse<void>> updatePlanItem(PlanItemDto dto);
  Future<CommonResponse<void>> deletePlanItem(String id);
  Future<CommonResponse<List<PlanItemEntity>>> fetchAllActivePlanItems();
}

class PlanItemRemoteDataSourceImpl implements PlanItemDataSource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("PlanItemRemote");

  PlanItemRemoteDataSourceImpl(this.client);

  @override
  Future<CommonResponse<List<PlanItemEntity>>> fetchItemsByPlanId(
      String planId) async {
    try {
      final json =
          await client.from('plan_items').select().eq('plan_id', planId);

      final items = (json as List<dynamic>)
          .map((e) => PlanItemEntity.fromJson(e))
          .toList();

      return ResponseUtil.commonResponse(ResponseConstant.code1000, items);
    } catch (e, s) {
      _logger.e("Fetch failed", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> createPlanItem(PlanItemInsertDto dto) async {
    try {
      await client.from('plan_items').insert(dto.toJson());
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("Insert failed", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> updatePlanItem(PlanItemDto dto) async {
    try {
      await client
          .from('plan_items')
          .update(dto.toUpdateJson())
          .eq('id', dto.id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("Update failed", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> deletePlanItem(String id) async {
    try {
      await client.from('plan_items').delete().eq('id', id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("Delete failed", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<List<PlanItemEntity>>> fetchAllActivePlanItems() async {
    try {
      final json = await client
          .from('plan_items')
          .select('*, plans!inner(is_archived)')
          .eq('plans.is_archived', false);
      final items = (json as List<dynamic>)
          .map((e) => PlanItemEntity.fromJson(e))
          .toList();
      return ResponseUtil.commonResponse(ResponseConstant.code1000, items);
    } catch (e, s) {
      _logger.e("Fetch all active plan items failed", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
