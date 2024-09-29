import 'dart:convert';

import 'package:budget_wise/src/data/models/GeneralResponse.dart';
import 'package:budget_wise/src/data/models/transaction.dart';
import 'package:budget_wise/src/presentation/constant/constants.dart';
import 'package:http/http.dart' as http;

class TransactionsRepository {
  // global request context
  static const String transactionsPath =
      '${Constants.baseUrl}${Constants.contextPath}${Constants.transactions}';

  // Fetch transactions
  Future<List<Transaction>> getTransactions() async {
    final url = Uri.parse(transactionsPath);
    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Assuming the server returns the transactions as JSON
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        List<Transaction> transactions = (generalResponse.data as List)
            .map((ts) => Transaction.fromJson(ts))
            .toList();
        return transactions;
      } else {
        throw Exception(
            'Failed to retrieve transactions. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while retrieving transactions: $error');
    }
  }

  // Fetch transactions
  Future<List<Transaction>> createTransactions(Transaction ts) async {
    final url = Uri.parse(transactionsPath);
    try {
      Transaction transaction = Transaction.create(
          name: ts.name,
          amount: ts.amount,
          operation: ts.operation,
          planId: ts.planId,
          accountId: ts.accountId);
      String transactionJson = jsonEncode(transaction.toJson());
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: transactionJson,
      );

      if (response.statusCode == 200) {
        // Assuming the server returns the transactions as JSON
        dynamic responseBody = jsonDecode(response.body);
        GeneralResponse generalResponse =
            GeneralResponse.fromJson(responseBody);
        List<Transaction> transactions = (generalResponse.data as List)
            .map((ts) => Transaction.fromJson(ts))
            .toList();
        return transactions;
      } else {
        throw Exception(
            'Failed to retrieve transactions. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error occurred while retrieving transactions: $error');
    }
  }
}
