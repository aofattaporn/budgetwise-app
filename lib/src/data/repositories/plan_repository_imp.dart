import 'package:budget_wise/src/data/datasources/plan_datasource.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/repositories/plan_repository.dart';

class PlanRepositoryImp implements PlanRepository {
  final PlanDataSource planDataSource;
  PlanRepositoryImp({required this.planDataSource});

  @override
  Future<void> createPlan(PlanEntity plan) {
    return planDataSource.createPlan(plan);
  }

  @override
  Future<List<PlanEntity>> getAllPlans() {
    return planDataSource.fetchAllPlans();
  }

  @override
  Future<PlanEntity?> getPlanByYearMonth(int year, int month) {
    return planDataSource.fetchPlanByYearMonth(year, month);
  }

  @override
  Future<PlanEntity?> getPlanByMonthId(int id) {
    return planDataSource.fetchPlanById(id);
  }

  @override
  Future<void> updatePlan(PlanEntity plan) {
    return planDataSource.updatePlan(plan);
  }

  @override
  Future<PlanEntity?> getPlanByIntervalTime(
      DateTime startTime, DateTime endTime) {
    return planDataSource.fetchPlanByStartAndEndDate(startTime, endTime);
  }

  @override
  Future<void> deletePlan(int planId) {
    return planDataSource.deletePlanById(planId);
  }
}
