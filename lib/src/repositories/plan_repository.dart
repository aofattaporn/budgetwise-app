import 'package:budget_wise/src/configs/log/logger_config.dart';
import 'package:budget_wise/src/configs/supabase/supabase_config.dart';
import 'package:budget_wise/src/models/entity/plan.dart';
import 'package:intl/intl.dart';

class PlanRepository {
  final logger = getLogger('PlanRepository');
  final planDB = dbClient.from('plans');

  Future<List<Plan>> getPlans() async {
    try {
      final response = await planDB.select();
      return response.map((map) => Plan.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch plans: $e');
    }
  }

  Future<Plan?> getPlanCurrentMonth() async {
    try {
      final now = DateTime.now();
      final formattedNow = DateFormat('yyyy-MM-dd').format(now);

      final response = await planDB
          .select()
          // .gte('start_date', formattedNow)
          // .lte('end_date', formattedNow);
          .lte('start_date', formattedNow)
          .gte('end_date', formattedNow);

      if (response.isNotEmpty) {
        return Plan.fromMap(response.first);
      } else {
        return null;
      }
    } catch (ex) {
      logger.e('[Error] : Failed to fetch plan by current-month');
      throw Exception(ex);
    }
  }

  // Get a single plan by ID
  Future<Plan?> getPlanById(int planId) async {
    try {
      final response = await planDB.select().eq('id', planId).single();
      return Plan.fromMap(response);
    } catch (e) {
      return null; // Return null if plan is not found
    }
  }

  // Insert a new plan
  Future<void> insertPlan(Plan plan) async {
    try {
      await planDB.insert(plan.toMap());
    } catch (e) {
      throw Exception('Failed to insert plan: $e');
    }
  }

  // Update an existing plan
  Future<void> updatePlan(Plan plan) async {
    try {
      await planDB.update(plan.toMap()).eq('id', plan.id);
    } catch (e) {
      throw Exception('Failed to update plan: $e');
    }
  }

  // Delete a plan by ID
  Future<void> deletePlan(int planId) async {
    try {
      await planDB.delete().eq('id', planId);
    } catch (e) {
      throw Exception('Failed to delete plan: $e');
    }
  }
}
