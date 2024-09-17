import 'package:budget_wise/src/data/models/account.dart';

class Planning {
  String planId;
  String name;
  double limit;
  int indexIcon;
  int accountId;
  DateTime? createDate;
  DateTime? updatePlanDate;

  Planning(
    this.planId,
    this.name,
    this.limit,
    this.indexIcon,
    this.accountId,
  );

  Planning.create({
    required this.name,
    required this.limit,
    required this.indexIcon,
    required this.accountId,
  })  : planId = _generatePlanId(),
        createDate = DateTime.now(),
        updatePlanDate = null;

  // Method to generate a unique planId (you can modify the logic as needed)
  static String _generatePlanId() {
    return DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Example: using timestamp as ID
  }

  // Method to validate the Planning data
  bool validate() {
    if (name.isEmpty) {
      throw Exception("Name cannot be empty.");
    }
    if (limit <= 0) {
      throw Exception("Limit must be greater than zero.");
    }
    if (accountId == null) {
      throw Exception("An account must be selected.");
    }
    return true;
  }

  // Method to handle the request before creating the data
  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'name': name,
      'limit': limit,
      'indexIcon': indexIcon,
      'account': accountId,
      'createDate': createDate
    };
  }
}
