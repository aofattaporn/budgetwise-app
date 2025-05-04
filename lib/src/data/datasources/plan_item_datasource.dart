import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/errors/bussiness_error.dart';
import 'package:budget_wise/src/core/utils/error_util.dart';
import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlanItemDataSource {
  Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId);
  Future<CommonResponse<List<PlanItemEntity>>> createNewPlanItem(
      PlanItemDto planItemDto);
  Future<CommonResponse<List<PlanItemEntity>>> deletePlanIteById(
      String planItemId, int planId);
}

class PlanItemDataSourceImpl implements PlanItemDataSource {
  final SupabaseClient supabase;
  final Logger _logger = LoggerUtil.datasourceLogger("PlanItemDataSourceImpl");

  PlanItemDataSourceImpl(this.supabase);

  @override
  Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId) async {
    try {
      final response =
          await supabase.from('plan_items').select().eq('plan_id', planId);

      final planItemList = response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, planItemList);
    } on BussinessError {
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Technical Error | fetchPlanById: $planId',
          error: e, stackTrace: stackTrace);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<List<PlanItemEntity>>> createNewPlanItem(
      PlanItemDto planItemDto) async {
    try {
      await supabase
          .from('plan_items')
          .insert(PlanItemEntity.toJsonInsert(planItemDto))
          .select();

      final response = await supabase
          .from('plan_items')
          .select()
          .eq('plan_id', planItemDto.planId);

      final planItemList = response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();

      return ResponseUtil.commonResponse(
        ResponseConstant.code1000,
        planItemList,
      );
    } on BussinessError {
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        'Technical Error | createNewPlanItem: ',
        error: e,
        stackTrace: stackTrace,
      );
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<List<PlanItemEntity>>> deletePlanIteById(
      String planItemId, int planId) async {
    try {
      await supabase.from('plan_items').delete().eq('id', planItemId);

      final response =
          await supabase.from('plan_items').select().eq('plan_id', planId);

      final planItemList = response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();

      return ResponseUtil.commonResponse(
        ResponseConstant.code1000,
        planItemList,
      );
    } on BussinessError {
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        'Technical Error | deletePlanIteById: id=$planItemId',
        error: e,
        stackTrace: stackTrace,
      );
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
