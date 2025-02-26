import 'package:budget_wise/src/models/operation.dart';
import 'package:flutter/material.dart';

class BusinessConstant {
  static const String BathUnit = "B";

  static const String tranfersType = "tranfers";
  static const String savingType = "saving";
  static const String successMessage = "You will be contacted by us very soon.";

  // transacction Constants
  static final List<OperationModel> operations = [
    OperationModel("transfer", const Icon(Icons.arrow_upward_rounded)),
    OperationModel("income", const Icon(Icons.arrow_downward_rounded)),
    OperationModel("change", const Icon(Icons.autorenew_rounded))
  ];

  // API Constants
  static const String contextPath = "/api";
}
