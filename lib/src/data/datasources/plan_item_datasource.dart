import 'package:budget_wise/src/domain/entities/plan_item_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlanItemDataSource {
  Future<List<PlanItemEntity>?> fetchPlanById(int planId);
}

class PlanItemDataSourceImpl implements PlanItemDataSource {
  final SupabaseClient supabase;

  PlanItemDataSourceImpl(this.supabase);

  @override
  Future<List<PlanItemEntity>?> fetchPlanById(int planId) async {
    final response =
        await supabase.from('plan_id').select().eq('plan_id', planId);
    if (response.isEmpty) return [];
    return response
        .map<PlanItemEntity>((json) => PlanItemEntity.fromJson(json))
        .toList();
  }
}
