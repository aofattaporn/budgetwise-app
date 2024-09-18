import 'dart:convert';

import 'package:budget_wise/src/data/models/GeneralResponse.dart';
import 'package:budget_wise/src/data/models/salary.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  // global request context
  static const String usersPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.users}';

  Future<Salary> fetchAllAccounts() async {
    final url = Uri.parse('$usersPath/salary');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        Salary salary = Salary.fromJson(generalResponse.data);
        return salary;
      } else {
        throw Exception(
            'Failed to load accounts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while fetching accounts: $error');
    }
  }
}
