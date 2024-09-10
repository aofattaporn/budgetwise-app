import 'dart:convert';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:budget_wise/src/data/models/account.dart';
import 'package:http/http.dart' as http;

class AccountsProvider {
  // global request context
  static const String accountsPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.accounts}';

  // api: find all accounts
  Future<List<Account>> findAllAccounts() async {
    final url = Uri.parse('$accountsPath');
    try {
      final response = await http.get(url);
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

  // api: create accounts
  Future<List<Account>> creatwAccount() async {
    final url = Uri.parse('$accountsPath');
    try {
      final response = await http.post(url);

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
