import 'package:budget_wise/src/models/operation.dart';
import 'package:flutter/material.dart';

class Constants {
  // String constant
  static const String successMessage = "You will be contacted by us very soon.";

  // Color constants
  static const Color primaryColor = Color(0xFF2196F3); // Blue color
  static const Color secondaryColor = Color(0xFFFFC107); // Amber color

  static const Color bgPrimary = Color.fromARGB(250, 250, 250, 100);

  static final List<Operation> operations = [
    Operation("transfer", const Icon(Icons.arrow_upward_rounded)),
    Operation("income", const Icon(Icons.arrow_downward_rounded)),
    Operation("change", const Icon(Icons.autorenew_rounded))
  ];

  static const String baseUrl = "http://127.0.0.1:8080";
  static const String contextPath = "/api";
  static const String accounts = "/accounts";
  static const String plans = "/plans";
  static const String users = "/usersfin";
  static const String transactions = "/transactions";
}
