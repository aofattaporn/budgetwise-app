import 'package:flutter/widgets.dart';

class Account {
  final String accountName;
  final double balance;
  final DateTime lastOperated;
  final Color colorStart;
  final Color colorEnd;

  Account(
    this.accountName,
    this.balance,
    this.lastOperated,
    this.colorStart,
    this.colorEnd,
  );

  // Convert an Account object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'balance': balance,
      'lastOperated': lastOperated.toIso8601String(),
      'colorStart': colorStart.value, // Convert color to int representation
      'colorEnd': colorEnd.value,
    };
  }

  // Convert a Map (JSON) into an Account object.
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      json['accountName'],
      (json['balance'] as num).toDouble(),
      DateTime.parse(json['lastOperated']),
      Color(json['colorStart']),
      Color(json['colorEnd']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.accountName == accountName &&
        other.balance == balance &&
        other.lastOperated == lastOperated &&
        other.colorStart == colorStart &&
        other.colorEnd == colorEnd;
  }
}
