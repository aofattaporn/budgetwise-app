import 'package:budget_wise/src/core/errors/bussiness_error.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/utils/error_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/utils/logger_util.dart';

abstract class PlanDataSource {
  Future<CommonResponse<PlanEntity?>> fetchPlanById(String id);
  Future<CommonResponse<PlanEntity?>> fetchPlanByDateRange(
      DateTime start, DateTime end);
  Future<CommonResponse<PlanEntity?>> fetchPlanByYearMonth(int year, int month);
  Future<CommonResponse<List<PlanEntity>>> fetchAllPlans();
  Future<CommonResponse<void>> createPlan(PlanDto dto);
  Future<CommonResponse<void>> updatePlan(String id, PlanDto dto);
  Future<CommonResponse<void>> deletePlan(String id);
}

class PlanRemoteDataSourceImpl implements PlanDataSource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("PlanRemote");

  PlanRemoteDataSourceImpl(this.client);

  @override
  Future<CommonResponse<PlanEntity?>> fetchPlanById(String id) async {
    try {
      final json =
          await client.from('plans').select().eq('id', id).maybeSingle();
      if (json == null) {
        throw ErrorUtil.mapBusinessError(message: "Plan not found");
      }
      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, PlanEntity.fromJson(json));
    } catch (e, s) {
      _logger.e("fetchPlanById", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<PlanEntity?>> fetchPlanByDateRange(
      DateTime start, DateTime end) async {
    try {
      final json = await client
          .from('plans')
          .select()
          .eq('is_archived', false)
          .lte('start_date', DateFormat('yyyy-MM-dd').format(start))
          .gte('end_date', DateFormat('yyyy-MM-dd').format(end));

      if (json.isEmpty) {
        return ResponseUtil.commonError(
            code: ResponseConstant.code1799,
            data: null,
            desc:
                "No active plan found in range [${UtilsDateTime.dateTimeReadableFormat(start)} - ${UtilsDateTime.dateTimeReadableFormat(end)}]");
      }

      final plans =
          json.map<PlanEntity>((e) => PlanEntity.fromJson(e)).toList();

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, plans.first);
    } catch (e, s) {
      _logger.e("supabase error (technical)", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<PlanEntity?>> fetchPlanByYearMonth(
      int year, int month) async {
    try {
      final json = await client
          .from('plans')
          .select()
          .filter('extract(year from start_date)', 'eq', year)
          .filter('extract(month from start_date)', 'eq', month);

      final plans =
          json.map<PlanEntity>((e) => PlanEntity.fromJson(e)).toList();

      if (json.isEmpty) {
        throw ErrorUtil.mapBusinessError(
            message: "No plan found active for [$year-$month]");
      }

      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, plans.first);
    } on BussinessError {
      rethrow;
    } catch (e, s) {
      _logger.e("fetchPlanByYearMonth", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<List<PlanEntity>>> fetchAllPlans() async {
    try {
      final response = await client.from('plans').select();
      final plans =
          response.map<PlanEntity>((e) => PlanEntity.fromJson(e)).toList();
      return ResponseUtil.commonResponse(ResponseConstant.code1000, plans);
    } catch (e, s) {
      _logger.e("fetchAllPlans", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> createPlan(PlanDto dto) async {
    try {
      await client.from('plans').insert({});
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("createPlan", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> updatePlan(String id, PlanDto dto) async {
    try {
      await client.from('plans').update({}).eq('id', id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("updatePlan", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> deletePlan(String id) async {
    try {
      await client.from('plans').delete().eq('id', id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("deletePlan", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
