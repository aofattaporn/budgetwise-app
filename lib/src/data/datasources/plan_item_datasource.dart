import 'package:budget_wise/src/common/model/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/errors/bussiness_error.dart';
import 'package:budget_wise/src/core/errors/technical_error.dart';
import 'package:budget_wise/src/core/utils/error_util.dart';
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
  final Logger _logger = LoggerUtil.datasourceLogger("PlanItemDataSourceImpl");

  PlanItemDataSourceImpl(this.supabase);

  @override
  Future<CommonResponse<List<PlanItemEntity>>> fetchPlanById(int planId) async {
    try {
      final response =
          await supabase.from('plan_items').select().eq('plan_id', planId);

      if (response.isEmpty) {
        _logger.e("Business Error | No plan items found for planId: $planId");
        throw ErrorUtil.mapBusinessError(
            message: "No plan items found for this plan");
      }

      final planItemList = response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, planItemList);
    } catch (e, stackTrace) {
      _logger.e('Technical Error | fetchPlanById: $planId',
          error: e, stackTrace: stackTrace);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
