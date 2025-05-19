import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';

abstract class PlanRepository {
  Future<PlanDto?> getPlanByIntervalTime(DateTime startTime, DateTime endTime);
  Future<PlanEntity?> getPlanByYearMonth(int year, int month);
  Future<PlanDto?> getPlanByMonthId(String id);
  Future<List<PlanDto>> getAllPlans();
  Future<void> createPlan(PlanDto plan);
  Future<void> updatePlan(PlanDto plan, String id);
  Future<void> deletePlan(String planId);
}

class PlanRepositoryImp implements PlanRepository {
  final PlanDataSource planDataSource;
  PlanRepositoryImp({required this.planDataSource});

  @override
  Future<List<PlanDto>> getAllPlans() async {
    final response = await planDataSource.fetchAllPlans();
    final List<PlanEntity> rawList = ResponseUtil.handleResponse(response);
    final List<PlanDto> plans =
        rawList.map((json) => PlanDto.fromEntity(json)).toList();

    return plans;
  }

  @override
  Future<PlanDto?> getPlanByIntervalTime(
      DateTime startTime, DateTime endTime) async {
    final rawResp =
        await planDataSource.fetchPlanByDateRange(startTime, endTime);
    final PlanEntity? planEntity = ResponseUtil.handleResponse(rawResp);
    return PlanDto.fromEntity(planEntity!);
  }

  @override
  Future<PlanDto?> getPlanByMonthId(String id) async {
    final rawResp = await planDataSource.fetchPlanById(id);
    final PlanEntity? planEntity = ResponseUtil.handleResponse(rawResp);
    return PlanDto.fromEntity(planEntity!);
  }

  @override
  Future<void> createPlan(PlanDto plan) async {
    final response = await planDataSource.createPlan(plan);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<PlanEntity?> getPlanByYearMonth(int year, int month) async {
    final response = await planDataSource.fetchPlanByYearMonth(year, month);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<void> deletePlan(String planId) async {
    final response = await planDataSource.deletePlan(planId);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<void> updatePlan(PlanDto plan, String id) {
    throw UnimplementedError();
  }
}
