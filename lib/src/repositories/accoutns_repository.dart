import 'dart:convert';

import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/models/internal/general_response.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class AccountsRepository {
  // global request context
  static const String accountsPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.accounts}';

  Future<List<BudgetAccountEntity>> fetchAllAccounts() async {
    final url = Uri.parse(accountsPath);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        List<BudgetAccountEntity> accountList = (generalResponse.data as List)
            .map((x) => BudgetAccountEntity.fromJson(x))
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
  Future<void> createAccount(BudgetAccountEntity account) async {
    final url = Uri.parse(accountsPath);
    try {
      // Convert Account object to JSON
      BudgetAccountEntity createAccount = BudgetAccountEntity.forCreation(
          accountName: account.accountName,
          balance: account.balance,
          colorIndex: account.colorIndex);
      String accountJson = jsonEncode(createAccount.createJsonRequest());
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: accountJson,
      );
    } catch (error) {
      throw Exception('Error occurred while creating account: $error');
    }
  }

  // client api: delete accounts
  Future<void> deleteAccountById(int accountId) async {
    final url = Uri.parse('$accountsPath/$accountId');
    try {
      await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      throw Exception('Error occurred while deleting account: $error');
    }
  }

  // client api: update accounts by id
  Future<void> updateAccountById(BudgetAccountEntity acccount) async {
    final url = Uri.parse('$accountsPath/${acccount.accountId}');
    try {
      BudgetAccountEntity createAccount = BudgetAccountEntity.forCreation(
          accountName: acccount.accountName,
          balance: acccount.balance,
          colorIndex: acccount.colorIndex);
      String accountJson = jsonEncode(createAccount.createJsonRequest());
      await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: accountJson,
      );
    } catch (error) {
      throw Exception('Error occurred while updating account: $error');
    }
  }
}
