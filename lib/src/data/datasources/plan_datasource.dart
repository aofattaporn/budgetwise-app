import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import '../../core/utils/logger_util.dart';

abstract class PlanDataSource {
  Future<PlanEntity?> fetchPlanByStartAndEndDate(
      DateTime startTime, DateTime endDate);
  Future<PlanEntity?> fetchPlanById(int id);
  Future<PlanEntity?> fetchPlanByYearMonth(int year, int month);
  Future<List<PlanEntity>> fetchAllPlans();
  Future<void> createPlan(PlanEntity plan);
  Future<void> updatePlan(PlanDto plan, int id);
  Future<void> deletePlanById(int id);
}

class PlanRemoteDataSourceImpl implements PlanDataSource {
  final SupabaseClient supabase;
  final Logger _logger =
      LoggerUtil.datasourceLogger("PlanRemoteDataSourceImpl");

  PlanRemoteDataSourceImpl(this.supabase);

  PlanEntity _mapToEntity(Map<String, dynamic> json) {
    return PlanEntity(
      id: json['id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalBudget: (json['total_budget'] as num).toDouble(),
      createAt: DateTime.parse(json['create_at']),
      summaryTranfer: (json['summary_tranfer'] ?? 0).toDouble(),
      summarySaving: (json['summary_saving'] ?? 0).toDouble(),
      summaryOther: (json['summary_other'] ?? 0).toDouble(),
    );
  }

  @override
  Future<PlanEntity?> fetchPlanByStartAndEndDate(
      DateTime start, DateTime end) async {
    try {
      final response = await supabase
          .from('plans')
          .select()
          .lte('start_date', DateFormat('yyyy-MM-dd').format(start))
          .gte('end_date', DateFormat('yyyy-MM-dd').format(end))
          .limit(1)
          .maybeSingle();

      return response == null ? null : _mapToEntity(response);
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanByStartAndEndDate",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<PlanEntity?> fetchPlanById(int id) async {
    try {
      final response =
          await supabase.from('plans').select().eq('id', id).maybeSingle();
      return response == null ? null : _mapToEntity(response);
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanById", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<PlanEntity?> fetchPlanByYearMonth(int year, int month) async {
    try {
      final response = await supabase
          .from('plans')
          .select()
          .eq('EXTRACT(YEAR FROM start_date)', year)
          .eq('EXTRACT(MONTH FROM start_date)', month)
          .single();

      return _mapToEntity(response);
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanByYearMonth",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<PlanEntity>> fetchAllPlans() async {
    try {
      final response = await supabase.from('plans').select();
      return response.map<PlanEntity>((json) => _mapToEntity(json)).toList();
    } catch (e, stackTrace) {
      _logger.e("Error in fetchAllPlans", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> createPlan(PlanEntity plan) async {
    try {
      await supabase.from('plans').insert({
        'start_date': plan.startDate.toIso8601String(),
        'end_date': plan.endDate.toIso8601String(),
        'total_budget': plan.totalBudget,
        'create_at': plan.createAt.toIso8601String(),
      });
    } catch (e, stackTrace) {
      _logger.e("Error in createPlan", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updatePlan(PlanDto plan, int id) async {
    try {
      await supabase.from('plans').update({
        'start_date': plan.startDate.toIso8601String(),
        'end_date': plan.endDate.toIso8601String(),
        'total_budget': plan.totalBudget,
        'update_at': DateTime.now().toIso8601String()
      }).eq('id', id);
    } catch (e, stackTrace) {
      _logger.e("Error in updatePlan", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deletePlanById(int id) async {
    try {
      await supabase.from('plans').delete().eq('id', id);
    } catch (e, stackTrace) {
      _logger.e("Error in deletePlanById", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
