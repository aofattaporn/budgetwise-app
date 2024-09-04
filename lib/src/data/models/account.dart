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
}
