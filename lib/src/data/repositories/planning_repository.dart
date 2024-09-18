import 'dart:convert';

import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class PlanningRepository {
  // global request context
  static const String planningPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.plans}';

  // Create a new account
  Future<void> createAccount(Planning plan) async {
    final url = Uri.parse(planningPath);
    try {
      // Convert Account object to JSON
      // Planning createAccount = Planning.forCreation(
      //     accountName: account.accountName,
      //     balance: account.balance,
      //     colorIndex: account.colorIndex);
      // String accountJson = jsonEncode(createAccount.createJsonRequest());
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: {},
      );

      if (response.statusCode == 200) {
        // Assuming the server returns the created account as JSON
        dynamic responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {
        throw Exception(
            'Failed to create account. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while creating account: $error');
    }
  }
}