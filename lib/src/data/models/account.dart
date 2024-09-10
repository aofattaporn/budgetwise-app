import 'package:flutter/widgets.dart';

class Account {
  String accountName;
  double Balance;
  DateTime lastOperated;
  Color colorStart;
  Color colorEnd;

  Account(
    this.accountName,
    this.Balance,
    this.lastOperated,
    this.colorStart,
    this.colorEnd,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.accountName == accountName &&
        other.Balance == Balance &&
        other.lastOperated == lastOperated &&
        other.colorStart == colorStart &&
        other.colorEnd == colorEnd;
  }

  @override
  int get hashCode {
    return accountName.hashCode ^
        Balance.hashCode ^
        lastOperated.hashCode ^
        colorStart.hashCode ^
        colorEnd.hashCode;
  }
}
