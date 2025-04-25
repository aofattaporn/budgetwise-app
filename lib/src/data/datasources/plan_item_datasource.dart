import 'package:budget_wise/src/common/model/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlanItemDataSource {
  Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId);
}

class PlanItemDataSourceImpl implements PlanItemDataSource {
  final SupabaseClient supabase;

  PlanItemDataSourceImpl(this.supabase);
  final Logger _logger =
      LoggerUtil.datasourceLogger("PlanRemoteDataSourceImpl");

  @override
  Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId) async {
    try {
      final response =
          await supabase.from('plan_id').select().eq('plan_id', planId);
      final planItemList = response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();
      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, planItemList);
    } catch (e, stackTrace) {
      _logger.e('Error occur fetchPlanById: $planId',
          error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, []);
    }
  }
}
