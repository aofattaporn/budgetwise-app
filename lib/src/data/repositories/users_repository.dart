import 'dart:convert';

import 'package:budget_wise/src/data/models/GeneralError.dart';
import 'package:budget_wise/src/data/models/userFin.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/utils/response_util.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  // global request context
  static const String usersPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.users}';

  /// Fetches user accounts for a given month and year.
  ///
  /// [monthYear] in 'MM-YYYY' format.
  /// Returns a [Future] with [UserFin] data.
  Future<UserFin> fetchAllAccounts(String monthYear) async {
    final url = Uri.parse('$usersPath/salary?monthYear=$monthYear');
    try {
      final response = await http.get(url);
      final generalResponse = ResponseUtil.decodeResponse(response);
      final userFin = UserFin.fromJson(generalResponse.data);
      return userFin;
    } catch (error) {
      throw error as GeneralError;
    }
  }

  Future<UserFin> addNewSalaryByMonth(UserFin body) async {
    final url = Uri.parse(usersPath);
    try {
      UserFin req =
          UserFin.createSalary(salary: body.salary, month: body.month);
      String reqJson = jsonEncode(req.toNewJsonSalary());
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: reqJson);
      final generalResponse = ResponseUtil.decodeResponse(response);
      final userFin = UserFin.fromJson(generalResponse.data);
      return userFin;
    } catch (error) {
      throw error as GeneralError;
    }
  }
}
