import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/plan_dto.dart';

abstract class PlanRepository {
  Future<PlanEntity?> getPlanByIntervalTime(
      DateTime startTime, DateTime endTime);
  Future<PlanEntity?> getPlanByYearMonth(int year, int month);
  Future<PlanEntity?> getPlanByMonthId(int id);
  Future<List<PlanEntity>> getAllPlans();
  Future<void> createPlan(PlanEntity plan);
  Future<void> updatePlan(PlanDto plan, int id);
  Future<void> deletePlan(int planId);
}
