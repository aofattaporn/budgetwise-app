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
        List<Account> accountList = (generalResponse.data as List)
            .map((x) => Account.fromJson(x))
            .toList();
        return accountList;
      } else {
        throw Exception(
            'Failed to load accounts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while fetching accounts: $error');
    }
  }

  // Create a new account
  Future<void> createAccount(Account account) async {
    final url = Uri.parse(accountsPath);
    try {
      // Convert Account object to JSON
      Account x = Account.forCreation(
          accountName: account.accountName,
          balance: account.balance,
          colorIndex: account.colorIndex);
      String accountJson = jsonEncode(x.createJsonRequest());
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
      } else {
        throw Exception(
            'Failed to create account. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while creating account: $error');
    }
  }
}
