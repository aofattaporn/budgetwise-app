import 'package:flutter/widgets.dart';

class Account {
  final int accountId; // Corresponds to account_id
  final String accountName; // Corresponds to name
  final double balance; // Corresponds to amount
  final DateTime createDate; // Corresponds to create_date
  final DateTime updatePlanDate; // Corresponds to update_plan_date
  final Color colorStart; // New field
  final Color colorEnd; // New field

  Account({
    required this.accountId,
    required this.accountName,
    required this.balance,
    required this.createDate,
    required this.updatePlanDate,
    required this.colorStart,
    required this.colorEnd,
  });

  // Convert an Account object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'accountName': accountName,
      'balance': balance,
      'createDate': createDate.toIso8601String(),
      'updatePlanDate': updatePlanDate.toIso8601String(),
      'colorStart': colorStart.value, // Convert color to int representation
      'colorEnd': colorEnd.value,
    };
  }

  // Convert a Map (JSON) into an Account object.
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountId: json['accountId'], // Added accountId
      accountName: json['accountName'],
      balance: (json['balance'] as num).toDouble(),
      createDate: DateTime.parse(json['createDate']), // Changed to createDate
      updatePlanDate:
          DateTime.parse(json['updatePlanDate']), // Changed to updatePlanDate
      colorStart: Color(json['colorStart']),
      colorEnd: Color(json['colorEnd']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.accountId == accountId && // Added accountId comparison
        other.accountName == accountName &&
        other.balance == balance &&
        other.createDate == createDate && // Changed to createDate
        other.updatePlanDate == updatePlanDate && // Changed to updatePlanDate
        other.colorStart == colorStart &&
        other.colorEnd == colorEnd;
  }
}
