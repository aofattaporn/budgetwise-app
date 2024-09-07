import 'package:budget_wise/src/data/models/operation.dart';
import 'package:flutter/material.dart';

class Constants {
  // String constant
  static const String successMessage = "You will be contacted by us very soon.";

  // Color constants
  static const Color primaryColor = Color(0xFF2196F3); // Blue color
  static const Color secondaryColor = Color(0xFFFFC107); // Amber color

  static const Color bgPrimary = Color.fromARGB(250, 250, 250, 100);

  static final List<Operation> operations = [
    Operation("Tranfer", const Icon(Icons.arrow_upward_rounded)),
    Operation("Incomin", const Icon(Icons.arrow_downward_rounded)),
    Operation("Change", const Icon(Icons.autorenew_rounded))
  ];
}
