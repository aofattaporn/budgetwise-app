import 'dart:convert';

import 'package:budget_wise/src/data/models/GeneralResponse.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class PlanningRepository {
  // global request context
  static const String planningPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.plans}';

  // Create a new account
  Future<List<Planning>> getPlans() async {
    final url = Uri.parse(planningPath);
    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      print(response.statusCode);

      if (response.statusCode == 200) {
        // Assuming the server returns the created account as JSON
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        List<Planning> plansList = (generalResponse.data as List)
            .map((plan) => Planning.fromJson(plan))
            .toList();
        return plansList;
      } else {
        throw Exception(
            'Failed to create account. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while retrive planing: $error');
    }
  }

  // Create a new account
  Future<List<Planning>> createPlanning(Planning plan) async {
    final url = Uri.parse(planningPath);
    try {
      Planning planning = Planning.create(
          name: plan.name,
          limit: plan.limit,
          indexIcon: plan.indexIcon,
          accountId: plan.accountId);
      String accountJson = jsonEncode(planning.toJson());
      final response = await http.post(
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
        List<Planning> plansList = (generalResponse.data as List)
            .map((plan) => Planning.fromJson(plan))
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
}
