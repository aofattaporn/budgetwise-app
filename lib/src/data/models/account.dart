import 'package:flutter/widgets.dart';

class Account {
  final int accountId; // Corresponds to account_id
  final String accountName; // Corresponds to name
  final double balance; // Corresponds to amount
  final DateTime createDate; // Corresponds to create_date
  final DateTime updatePlanDate; // Corresponds to update_plan_date
  final int colorIndex; // New field

  Account({
    required this.accountId,
    required this.accountName,
    required this.balance,
    required this.createDate,
    required this.updatePlanDate,
    required this.colorIndex,
  });

  // Convert an Account object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'accountName': accountName,
      'balance': balance,
      'createDate': createDate.toIso8601String(),
      'updatePlanDate': updatePlanDate.toIso8601String(),
      'colorIndex': colorIndex, // Convert color to int representation
    };
  }

  // Convert a Map (JSON) into an Account object.
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountId: json['accountId'],
      accountName: json['accountName'],
      balance: (json['balance'] as num).toDouble(),
      createDate: DateTime.parse(json['createDate']),
      updatePlanDate: DateTime.parse(json['updatePlanDate']),
      colorIndex: json['colorIndex'],
    );
  }
}
