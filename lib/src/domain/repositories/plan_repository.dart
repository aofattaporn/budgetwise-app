import 'package:budget_wise/src/domain/entities/plan_entity.dart';

abstract class PlanRepository {
  Future<PlanEntity?> getPlanByYearMonth(int year, int month);
  Future<List<PlanEntity>> getAllPlans();
  Future<void> createPlan(PlanEntity plan);
  Future<void> updatePlan(PlanEntity plan);
}
