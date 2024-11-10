import 'dart:convert';

import 'package:budget_wise/src/models/internal/general_response.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/utils/response_util.dart';
import 'package:http/http.dart' as http;

class PlanningRepository {
  // global request context
  static const String planningPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.plans}';

  // Create a new account
  Future<List<PlanEntity>> getPlans(String monthYear) async {
    final url = Uri.parse('$planningPath?monthYear=$monthYear');
    try {
      final response = await http.get(
        url,
        headers: ResponseUtil.contentTypeJson,
      );
      final generalResponse = ResponseUtil.decodeResponse(response);
      List<PlanEntity> plansList = (generalResponse.data as List)
          .map((plan) => PlanEntity.fromJson(plan))
          .toList();
      return plansList;
    } catch (error) {
      throw Exception('Error occurred while retrive planing: $error');
    }
  }

  // Create a new account
  Future<List<PlanEntity>> createPlanning(PlanEntity plan) async {
    final url = Uri.parse(planningPath);
    try {
      PlanEntity planning = PlanEntity.create(
          name: plan.name,
          type: plan.type,
          limit: plan.limit,
          indexIcon: plan.indexIcon,
          accountId: plan.accountId,
          month: plan.month);
      String accountJson = jsonEncode(planning.toJson());
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: accountJson,
      );

      final generalResponse = ResponseUtil.decodeResponse(response);
      List<PlanEntity> plansList = (generalResponse.data as List)
          .map((plan) => PlanEntity.fromJson(plan))
          .toList();
      return plansList;
    } catch (error) {
      throw Exception('Error occurred while creating planning: $error');
    }
  }

  // Create a new account
  Future<List<PlanEntity>> updatePlanning(int planId, PlanEntity plan) async {
    final url = Uri.parse("$planningPath/$planId");
    try {
      PlanEntity planning = PlanEntity.create(
          type: plan.type,
          name: plan.name,
          limit: plan.limit,
          indexIcon: plan.indexIcon,
          accountId: plan.accountId,
          month: plan.month);
      String accountJson = jsonEncode(planning.toJson());
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: accountJson,
      );

      if (response.statusCode == 200) {
        // Assuming the server returns the created account as JSON
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        List<PlanEntity> plansList = (generalResponse.data as List)
            .map((plan) => PlanEntity.fromJson(plan))
            .toList();
        return plansList;
      } else {
        throw Exception(
            'Failed to create account. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while creating planning: $error');
    }
  }

  // delete a new planning
  Future<List<PlanEntity>> deletPlanning(int planId) async {
    final url = Uri.parse('$planningPath/$planId');
    try {
      final response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Assuming the server returns the created account as JSON
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        if (generalResponse.data == null) {
          return [];
        }
        List<PlanEntity> plansList = (generalResponse.data as List)
            .map((plan) => PlanEntity.fromJson(plan))
            .toList();

        return plansList;
      } else {
        throw Exception(
            'Failed to delete account. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while deleting planning: $error');
    }
  }
}
