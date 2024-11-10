import 'package:budget_wise/src/models/operation.dart';
import 'package:flutter/material.dart';

class Constants {
  /// **
  /// transacction Constants
  /// **
  static final List<OperationModel> operations = [
    OperationModel("transfer", const Icon(Icons.arrow_upward_rounded)),
    OperationModel("income", const Icon(Icons.arrow_downward_rounded)),
    OperationModel("change", const Icon(Icons.autorenew_rounded))
  ];

  /// **
  /// API Constants
  /// **
  static const String baseUrl = "http://127.0.0.1:8080";
  static const String contextPath = "/api";
  static const String accounts = "/accounts";
  static const String plans = "/plans";
  static const String users = "/usersfin";
  static const String transactions = "/transactions";

  static const String successMessage = "You will be contacted by us very soon.";
}
