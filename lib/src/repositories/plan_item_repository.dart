import 'package:budget_wise/src/configs/log/logger_config.dart';
import 'package:budget_wise/src/configs/supabase/supabase_config.dart';
import 'package:budget_wise/src/models/entity/plan_item.dart'; // Updated to use PlanItem
import 'package:intl/intl.dart';

class PlanItemRepository {
  final logger = getLogger('PlanItemBloc');
  final planItemDB = dbClient.from('plan_items');

  // Get all plan items
  Future<List<PlanItem>> getPlanItems() async {
    try {
      final response = await planItemDB.select();
      return response.map((map) => PlanItem.fromMap(map)).toList();
    } catch (e) {
      logger.e('[Error] Failed to fetch plan items: $e');
      throw Exception('Failed to fetch plan items: $e');
    }
  }

  // Get plan items for the current month
  Future<List<PlanItem>> getPlanItemsCurrentMonth() async {
    try {
      final response = await planItemDB.select().eq('plan_id', 1);
      return response.map((map) => PlanItem.fromMap(map)).toList();
    } catch (ex) {
      logger.e('[Error] Failed to fetch plan items for the current month: $ex');
      throw Exception('Failed to fetch plan items for the current month: $ex');
    }
  }

  // Get a single plan item by ID
  Future<PlanItem?> getPlanItemById(int planItemId) async {
    try {
      final response = await planItemDB.select().eq('id', planItemId).single();
      return PlanItem.fromMap(response);
    } catch (e) {
      logger.e('[Error] Failed to fetch plan item by ID ($planItemId): $e');
      return null;
    }
  }

  // Insert a new plan item
  Future<void> insertPlanItem(PlanItem planItem) async {
    try {
      await planItemDB.insert(planItem.toMap());
    } catch (e) {
      logger.e('[Error] Failed to insert plan item: $e');
      throw Exception('Failed to insert plan item: $e');
    }
  }

  // Update an existing plan item
  Future<void> updatePlanItem(PlanItem planItem) async {
    try {
      await planItemDB.update(planItem.toMap()).eq('id', planItem.id);
    } catch (e) {
      logger.e('[Error] Failed to update plan item with ID ${planItem.id}: $e');
      throw Exception('Failed to update plan item: $e');
    }
  }

  // Delete a plan item by ID
  Future<void> deletePlanItem(int planItemId) async {
    try {
      await planItemDB.delete().eq('id', planItemId);
    } catch (e) {
      logger.e('[Error] Failed to delete plan item with ID $planItemId: $e');
      throw Exception('Failed to delete plan item: $e');
    }
  }
}
