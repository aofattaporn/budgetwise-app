import 'dart:convert';

import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/GeneralResponse.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class AccountsRepository {
  // global request context
  static const String accountsPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.accounts}';

  Future<List<Account>> fetchAllAccounts() async {
    final url = Uri.parse('$accountsPath');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);

        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);

        print("=====================================");
        print(generalResponse.data);
        print("*************************************");

        // Ensure the data is a List and map it to Account objects
        List<dynamic> accountList = (generalResponse.data as List);
        List<Account> accounts =
            accountList.map((x) => Account.fromJson(x)).toList();

        print(accounts);
        print("=====================================");
        return [];
      } else {
        throw Exception(
            'Failed to load accounts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while fetching accounts: $error');
    }
  }

  Future<List<Account>> createAccount(Account account) async {
    final url = Uri.parse('$accountsPath');
    try {
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Account.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load accounts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching accounts: $e');
    }
  }
}
