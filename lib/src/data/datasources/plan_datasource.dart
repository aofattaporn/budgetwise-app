import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';

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

  PlanRemoteDataSourceImpl(this.supabase);

  @override
  Future<PlanEntity?> fetchPlanByStartAndEndDate(
      DateTime startDateTime, DateTime endDateTime) async {
    try {
      final response = await supabase
          .from('plans')
          .select()
          .lte('start_date', DateFormat('yyyy-MM-dd').format(startDateTime))
          .gte('end_date', DateFormat('yyyy-MM-dd').format(endDateTime))
          .limit(1)
          .maybeSingle();

      return response == null
          ? null
          : PlanEntity(
              id: response['id'],
              startDate: DateTime.parse(response['start_date']),
              endDate: DateTime.parse(response['end_date']),
              totalBudget: response['total_budget'].toDouble(),
              createAt: DateTime.parse(response['create_at']),
              summaryTranfer: response['summary_tranfer'].toDouble(),
              summarySaving: response['summary_saving'].toDouble(),
              summaryOther: response['summary_other'].toDouble(),
            );
    } catch (e) {
      print('Error in fetchPlanByStartAndEndDate: $e');
      return null;
    }
  }

  @override
  Future<PlanEntity?> fetchPlanById(int id) async {
    try {
      final response =
          await supabase.from('plans').select().eq('id', id).maybeSingle();

      return response == null
          ? null
          : PlanEntity(
              id: response['id'],
              startDate: DateTime.parse(response['start_date']),
              endDate: DateTime.parse(response['end_date']),
              totalBudget: response['total_budget'].toDouble(),
              createAt: DateTime.parse(response['create_at']),
              summaryTranfer: response['summary_tranfer'].toDouble(),
              summarySaving: response['summary_saving'].toDouble(),
              summaryOther: response['summary_other'].toDouble(),
            );
    } catch (e) {
      print('Error in fetchPlanById: $e');
      return null;
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

      return PlanEntity(
        id: response['id'],
        startDate: DateTime.parse(response['start_date']),
        endDate: DateTime.parse(response['end_date']),
        totalBudget: response['total_budget'].toDouble(),
        createAt: DateTime.parse(response['create_at']),
        summaryTranfer: response['summary_tranfer'].toDouble(),
        summarySaving: response['summary_saving'].toDouble(),
        summaryOther: response['summary_other'].toDouble(),
      );
    } catch (e) {
      print('Error in fetchPlanByYearMonth: $e');
      return null;
    }
  }

  @override
  Future<List<PlanEntity>> fetchAllPlans() async {
    try {
      final response = await supabase.from('plans').select();
      return response.map<PlanEntity>((plan) {
        return PlanEntity(
          id: plan['id'],
          startDate: DateTime.parse(plan['start_date']),
          endDate: DateTime.parse(plan['end_date']),
          totalBudget: plan['total_budget'].toDouble(),
          createAt: DateTime.parse(plan['create_at']),
          summaryTranfer: plan['summary_tranfer'].toDouble(),
          summarySaving: plan['summary_saving'].toDouble(),
          summaryOther: plan['summary_other'].toDouble(),
        );
      }).toList();
    } catch (e) {
      print('Error in fetchAllPlans: $e');
      return [];
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
    } catch (e) {
      print('Error in createPlan: $e');
      rethrow;
    }
  }

  @override
  Future<void> updatePlan(PlanDto planDto, int id) async {
    try {
      await supabase.from('plans').update({
        'start_date': planDto.startDate.toIso8601String(),
        'end_date': planDto.endDate.toIso8601String(),
        'total_budget': planDto.totalBudget,
        'update_at': DateTime.now().toIso8601String()
      }).eq('id', id);
    } catch (e) {
      print('Error in updatePlan: $e');
      rethrow;
    }
  }

  @override
  Future<void> deletePlanById(int id) async {
    try {
      await supabase.from('plans').delete().eq('id', id);
    } catch (e) {
      print('Error in deletePlanById: $e');
      rethrow;
    }
  }
}
