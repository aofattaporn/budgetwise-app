import 'package:budget_wise/src/common/model/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import '../../core/utils/logger_util.dart';

abstract class PlanDataSource {
  Future<CommonResponse<PlanEntity?>> fetchPlanByStartAndEndDate(
      DateTime startTime, DateTime endDate);
  Future<CommonResponse<PlanEntity?>> fetchPlanById(int id);
  Future<CommonResponse<PlanEntity?>> fetchPlanByYearMonth(int year, int month);
  Future<CommonResponse<List<PlanEntity>>> fetchAllPlans();
  Future<CommonResponse<Null>> createPlan(PlanDto plan);
  Future<CommonResponse<Null>> updatePlan(PlanDto plan, int id);
  Future<CommonResponse<Null>> deletePlanById(int id);
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
  Future<CommonResponse<PlanEntity?>> fetchPlanByStartAndEndDate(
      DateTime start, DateTime end) async {
    try {
      final response = await supabase
          .from('plans')
          .select()
          .lte('start_date', DateFormat('yyyy-MM-dd').format(start))
          .gte('end_date', DateFormat('yyyy-MM-dd').format(end))
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return ResponseUtil.commonResponse(ResponseConstant.code1899, null);
      }

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, PlanEntity.fromJson(response));
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanByStartAndEndDate",
          error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }

  @override
  Future<CommonResponse<PlanEntity?>> fetchPlanById(int id) async {
    try {
      final response =
          await supabase.from('plans').select().eq('id', id).maybeSingle();

      if (response == null) {
        return ResponseUtil.commonResponse(ResponseConstant.code1899, null);
      }
      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, PlanEntity.fromJson(response));
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanById", error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }

  @override
  Future<CommonResponse<PlanEntity?>> fetchPlanByYearMonth(
      int year, int month) async {
    try {
      final response = await supabase
          .from('plans')
          .select()
          .eq('EXTRACT(YEAR FROM start_date)', year)
          .eq('EXTRACT(MONTH FROM start_date)', month)
          .single();

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, PlanEntity.fromJson(response));
    } catch (e, stackTrace) {
      _logger.e("Error in fetchPlanByYearMonth",
          error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }

  @override
  Future<CommonResponse<List<PlanEntity>>> fetchAllPlans() async {
    try {
      final response = await supabase.from('plans').select();

      final planList =
          response.map<PlanEntity>((json) => _mapToEntity(json)).toList();
      return ResponseUtil.commonResponse(ResponseConstant.code1000, planList);
    } catch (e, stackTrace) {
      _logger.e("Error in fetchAllPlans", error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, []);
    }
  }

  @override
  Future<CommonResponse<Null>> createPlan(PlanDto plan) async {
    try {
      await supabase.from('plans').insert(PlanEntity.toJsonInsert(plan));

      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, stackTrace) {
      _logger.e("Error in createPlan", error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }

  @override
  Future<CommonResponse<Null>> updatePlan(PlanDto plan, int id) async {
    try {
      await supabase
          .from('plans')
          .update(PlanEntity.toJsonUpdate(plan))
          .eq('id', id);

      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, stackTrace) {
      _logger.e("Error in updatePlan", error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }

  @override
  Future<CommonResponse<Null>> deletePlanById(int id) async {
    try {
      await supabase.from('plans').delete().eq('id', id);

      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, stackTrace) {
      _logger.e("Error in deletePlanById", error: e, stackTrace: stackTrace);
      return ResponseUtil.commonResponse(ResponseConstant.code1999, null);
    }
  }
}
