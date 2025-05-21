import 'dart:convert';

import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
import 'package:budget_wise/src/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/entities/transaction_entity.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';
import 'package:budget_wise/src/domain/models/plan_info_dto.dart';
import 'package:budget_wise/src/domain/models/plan_info_summary.dart';
import 'package:logger/logger.dart';

abstract class PlanRepository {
  Future<PlanDto?> getPlanByIntervalTime(DateTime startTime, DateTime endTime);
  Future<PlanEntity?> getPlanByYearMonth(int year, int month);
  Future<PlanDto?> getPlanByMonthId(String id);
  Future<List<PlanDto>> getAllPlans();
  Future<PlanInfoSummary> fetchPlanAndPlanItemInfo(String planId);
  Future<void> createPlan(PlanDto plan);
  Future<void> updatePlan(PlanDto plan);
  Future<void> deletePlan(String planId);
}

class PlanRepositoryImp implements PlanRepository {
  final Logger _logger = LoggerUtil.normalLogger("PlanRepository");

  final PlanDataSource planDataSource;
  final TransactionDatasource transactionDatasource;

  PlanRepositoryImp(
      {required this.planDataSource, required this.transactionDatasource});

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
  Future<void> deletePlan(String planId) async {
    final response = await planDataSource.deletePlan(planId);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<PlanEntity?> getPlanByYearMonth(int year, int month) async {
    final response = await planDataSource.fetchPlanByYearMonth(year, month);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<void> updatePlan(PlanDto plan) async {
    final response = await planDataSource.updatePlan(plan);
    return ResponseUtil.handleResponse(response);
  }

  @override
  Future<PlanInfoSummary> fetchPlanAndPlanItemInfo(String planId) async {
    // Fetch plan + items
    final CommonResponse<PlanInfoDto> planResponse =
        await planDataSource.fetchPlanAndPlanItemInfo();
    final planInfo = planResponse.data;
    _logger.d("Fetched PlanInfo: ${planInfo.toJson()}");

    // Fetch transactions for this plan
    final rawTransactionResponse =
        await transactionDatasource.fetchTransactionByPlanId(planId);
    final transactions = ResponseUtil.handleResponse(rawTransactionResponse);
    _logger.d("Fetched Transactions: ${transactions.length}");

    // Calculate summary totals
    final summaryExpense = transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
    final summarySaving = transactions
        .where((t) => t.type == 'saving')
        .fold(0.0, (sum, t) => sum + t.amount);
    final summaryOther = transactions
        .where((t) => t.type != 'expense' && t.type != 'saving')
        .fold(0.0, (sum, t) => sum + t.amount);

    // Convert to summary object
    return PlanInfoSummary.fromInfo(
      json: planInfo,
      summaryExpense: summaryExpense,
      summarySaving: summarySaving,
      sumaryOther: summaryOther,
    );
  }
}
