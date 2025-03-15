import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanDataSource {
  Future<PlanEntity?> fetchPlanByYearMonth(int year, int month);
  Future<List<PlanEntity>> fetchAllPlans();
  Future<void> createPlan(PlanEntity plan);
  Future<void> updatePlan(PlanEntity plan);
}

class PlanRemoteDataSourceImpl implements PlanDataSource {
  final SupabaseClient supabase;

  PlanRemoteDataSourceImpl(this.supabase);

  @override
  Future<PlanEntity?> fetchPlanByYearMonth(int year, int month) async {
    final response = await supabase
        .from('plans')
        .select()
        .eq('EXTRACT(YEAR FROM start_date)', year)
        .eq('EXTRACT(MONTH FROM start_date)', month)
        .single();

    return PlanEntity(
      id: response['id'],
      startDate: DateTime.parse(response['start_date']),
      endDate: DateTime.parse(response['end_date']),
      totalBudget: response['total_budget'].toDouble(),
      createAt: DateTime.parse(response['create_at']),
    );
  }

  @override
  Future<List<PlanEntity>> fetchAllPlans() async {
    final response = await supabase.from('plans').select();
    return response.map<PlanEntity>((plan) {
      return PlanEntity(
        id: plan['id'],
        startDate: DateTime.parse(plan['start_date']),
        endDate: DateTime.parse(plan['end_date']),
        totalBudget: plan['total_budget'].toDouble(),
        createAt: DateTime.parse(plan['create_at']),
      );
    }).toList();
  }

  @override
  Future<void> createPlan(PlanEntity plan) async {
    await supabase.from('plans').insert({
      'start_date': plan.startDate.toIso8601String(),
      'end_date': plan.endDate.toIso8601String(),
      'total_budget': plan.totalBudget,
      'create_at': plan.createAt.toIso8601String(),
    });
  }

  @override
  Future<void> updatePlan(PlanEntity plan) async {
    await supabase.from('plans').update({
      'start_date': plan.startDate.toIso8601String(),
      'end_date': plan.endDate.toIso8601String(),
      'total_budget': plan.totalBudget,
      'create_at': plan.createAt.toIso8601String(),
    }).eq('id', plan.id);
  }
}
