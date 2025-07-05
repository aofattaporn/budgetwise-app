import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/shared/utils/response_util.dart';
import 'package:budget_wise/data/datasources/plan_datasource.dart';
import 'package:budget_wise/domain/entities/plan_entity.dart';
import 'package:budget_wise/data/models/plan_dto.dart';

abstract class PlanRepository {
  Future<PlanDto?> getPlanByIntervalTime(DateTime startTime, DateTime endTime);
  Future<PlanEntity?> getPlanByYearMonth(int year, int month);
  Future<PlanDto?> getPlanByMonthId(String id);
  Future<List<PlanDto>> getAllPlans();
  Future<void> createPlan(PlanDto plan);
  Future<void> updatePlan(PlanDto plan);
  Future<void> deletePlan(String planId);
}

class PlanRepositoryImp implements PlanRepository {
  final PlanDataSource _planDataSource;

  PlanRepositoryImp({required PlanDataSource planDataSource})
      : _planDataSource = planDataSource;

  @override
  Future<List<PlanDto>> getAllPlans() async {
    final response = await _planDataSource.fetchAllPlans();
    final List<PlanEntity> rawList = ResponseUtil.handleResponse(response);
    final List<PlanDto> plans =
        rawList.map((json) => PlanDto.fromEntity(json)).toList();

    return plans;
  }

  @override
  Future<PlanDto?> getPlanByIntervalTime(
      DateTime startTime, DateTime endTime) async {
    final rawResp =
        await _planDataSource.fetchPlanByDateRange(startTime, endTime);
    final PlanEntity? planEntity = ResponseUtil.handleResponse(rawResp);
    return PlanDto.fromEntity(planEntity!);
  }

  @override
  Future<PlanDto?> getPlanByMonthId(String id) async {
    final rawResp = await _planDataSource.fetchPlanById(id);
    final PlanEntity? planEntity = ResponseUtil.handleResponse(rawResp);
    return PlanDto.fromEntity(planEntity!);
  }

  @override
  Future<void> createPlan(PlanDto plan) async {
    final response = await _planDataSource.createPlan(plan);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<void> deletePlan(String planId) async {
    final response = await _planDataSource.deletePlan(planId);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<PlanEntity?> getPlanByYearMonth(int year, int month) async {
    final response = await _planDataSource.fetchPlanByYearMonth(year, month);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<void> updatePlan(PlanDto plan) async {
    final response = await _planDataSource.updatePlan(plan);
    return ResponseUtil.handleResponse(response);
  }
}
