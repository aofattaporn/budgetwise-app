import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlanItemDataSource {
  Future<List<PlanItemEntity>?> fetchPlanById(int planId);
}

class PlanItemDataSourceImpl implements PlanItemDataSource {
  final SupabaseClient supabase;

  PlanItemDataSourceImpl(this.supabase);
  final Logger _logger =
      LoggerUtil.datasourceLogger("PlanRemoteDataSourceImpl");

  @override
  Future<List<PlanItemEntity>?> fetchPlanById(int planId) async {
    try {
      final response =
          await supabase.from('plan_id').select().eq('plan_id', planId);
      if (response.isEmpty) return [];
      return response
          .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      _logger.e('Error occur fetchPlanById: $planId',
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
