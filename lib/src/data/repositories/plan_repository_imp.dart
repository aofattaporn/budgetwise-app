// import 'package:budget_wise/src/core/utils/response_util.dart';
// import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
// import 'package:budget_wise/src/domain/entities/plan_temp_entity.dart';
// import 'package:budget_wise/src/domain/models/plan_dto.dart';

// abstract class PlanRepository {
//   Future<PlanEntity?> getPlanByIntervalTime(
//       DateTime startTime, DateTime endTime);
//   Future<PlanEntity?> getPlanByYearMonth(int year, int month);
//   Future<PlanEntity?> getPlanByMonthId(int id);
//   Future<List<PlanEntity>> getAllPlans();
//   Future<void> createPlan(PlanDto plan);
//   Future<void> updatePlan(PlanDto plan, int id);
//   Future<void> deletePlan(int planId);
// }

// class PlanRepositoryImp implements PlanRepository {
//   final PlanDataSource planDataSource;
//   PlanRepositoryImp({required this.planDataSource});

//   @override
//   Future<void> createPlan(PlanDto plan) async {
//     final response = await planDataSource.createPlan(plan);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<List<PlanEntity>> getAllPlans() async {
//     final response = await planDataSource.fetchAllPlans();
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<PlanEntity?> getPlanByYearMonth(int year, int month) async {
//     final response = await planDataSource.fetchPlanByYearMonth(year, month);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<PlanEntity?> getPlanByMonthId(int id) async {
//     final response = await planDataSource.fetchPlanById(id);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<void> updatePlan(PlanDto plan, int id) async {
//     final response = await planDataSource.updatePlan(plan, id);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<PlanEntity?> getPlanByIntervalTime(
//       DateTime startTime, DateTime endTime) async {
//     final response =
//         await planDataSource.fetchPlanByStartAndEndDate(startTime, endTime);
//     return ResponseUtil.handleResponse(response);
//   }

//   @override
//   Future<void> deletePlan(int planId) async {
//     final response = await planDataSource.deletePlanById(planId);
//     return ResponseUtil.handleResponse(response);
//   }
// }
